/**
 * @license
 * Copyright 2025 Google LLC
 * SPDX-License-Identifier: Apache-2.0
 */

import {
  CountTokensResponse,
  GenerateContentResponse,
  GenerateContentParameters,
  CountTokensParameters,
  EmbedContentResponse,
  EmbedContentParameters,
} from '@google/genai';
import { ContentGenerator } from './contentGenerator.js';
import { ToolRegistry } from '../tools/tool-registry.js';
import { Config } from '../config/config.js';
import fs from 'fs';

// 增强的调试日志函数
function debugLog(msg: string, obj?: any, level: 'INFO' | 'WARN' | 'ERROR' | 'DEBUG' = 'INFO') {
  const timestamp = new Date().toISOString();
  const logEntry = `[${timestamp}] [${level}] ${msg}${obj ? ' ' + JSON.stringify(obj, null, 2) : ''}\n`;
  try {
    fs.appendFileSync('/tmp/gemini-debug.log', logEntry);
  } catch (error) {
    try {
      fs.appendFileSync('./gemini-debug.log', logEntry);
    } catch (e) {
      console.error(logEntry);
    }
  }
}

// 工具调用状态跟踪
interface ToolCallState {
  id: string;
  name: string;
  arguments: string;
  isComplete: boolean;
  startTime: number;
}

interface DeepseekMessage {
  role: 'system' | 'user' | 'assistant' | 'tool';
  content: string;
  tool_calls?: any[];
  tool_call_id?: string;
}

interface DeepseekRequest {
  model: string;
  messages: DeepseekMessage[];
  stream?: boolean;
  temperature?: number;
  max_tokens?: number;
  tools?: any[];
  tool_choice?: string;
}

interface DeepseekResponse {
  id: string;
  object: string;
  created: number;
  model: string;
  choices: Array<{
    index: number;
    message: {
      role: string;
      content: string;
      tool_calls?: Array<{
        id: string;
        type: string;
        function: {
          name: string;
          arguments: string;
        };
      }>;
    };
    finish_reason: string;
  }>;
  usage: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
}

interface DeepseekStreamResponse {
  id: string;
  object: string;
  created: number;
  model: string;
  choices: Array<{
    index: number;
    delta: {
      role?: string;
      content?: string;
      tool_calls?: Array<{
        index: number;
        id?: string;
        type?: string;
        function?: {
          name?: string;
          arguments?: string;
        };
      }>;
    };
    finish_reason: string | null;
  }>;
}

export class DeepseekAdapter implements ContentGenerator {
  private apiKey: string;
  private baseUrl: string;
  private toolRegistry: ToolRegistry | null = null;
  private config: Config | null = null;
  private maxRetries: number = 3;
  private retryDelay: number = 1000; // 1秒

  constructor(apiKey: string, baseUrl: string = 'https://api.deepseek.com') {
    debugLog('🔍 DeepSeek adapter constructor called', { baseUrl }, 'INFO');
    this.apiKey = apiKey;
    this.baseUrl = baseUrl;
  }

  // 设置工具注册表和配置
  setToolRegistry(toolRegistry: ToolRegistry, config: Config): void {
    debugLog('🔍 setToolRegistry called', { 
      hasToolRegistry: !!toolRegistry, 
      hasConfig: !!config,
      toolCount: toolRegistry?.getAllTools().length || 0
    }, 'INFO');
    this.toolRegistry = toolRegistry;
    this.config = config;
  }

  // 增强的请求方法，支持重试
  private async makeRequest(endpoint: string, data: any, retryCount: number = 0): Promise<any> {
    try {
      debugLog(`🔍 Making request to ${endpoint}`, { 
        retryCount, 
        hasTools: !!(data.tools && data.tools.length > 0),
        toolCount: data.tools?.length || 0
      }, 'DEBUG');

      const response = await fetch(`${this.baseUrl}${endpoint}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.apiKey}`,
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        const errorText = await response.text();
        const error = `Deepseek API error: ${response.status} ${response.statusText} - ${errorText}`;
        debugLog('🔍 API request failed', { 
          status: response.status, 
          statusText: response.statusText, 
          error: errorText,
          retryCount 
        }, 'ERROR');
        
        // 如果是可重试的错误且未超过重试次数
        if (retryCount < this.maxRetries && (response.status >= 500 || response.status === 429)) {
          debugLog(`🔍 Retrying request (${retryCount + 1}/${this.maxRetries})`, {}, 'WARN');
          await new Promise(resolve => setTimeout(resolve, this.retryDelay * (retryCount + 1)));
          return this.makeRequest(endpoint, data, retryCount + 1);
        }
        
        throw new Error(error);
      }

      const result = await response.json();
      debugLog(`🔍 Request successful`, { 
        hasChoices: !!result.choices,
        choiceCount: result.choices?.length || 0,
        hasToolCalls: !!(result.choices?.[0]?.message?.tool_calls?.length > 0)
      }, 'DEBUG');
      
      return result;
    } catch (error) {
      debugLog('🔍 Request error', { error: (error as Error).message, retryCount }, 'ERROR');
      throw error;
    }
  }

  private convertToDeepseekMessages(request: any): DeepseekMessage[] {
    const messages: DeepseekMessage[] = [];
    
    debugLog('🔍 Converting request to DeepSeek messages', { 
      hasContents: !!request.contents,
      contentCount: request.contents?.length || 0
    }, 'DEBUG');
    
    // 简单处理：从请求中提取文本内容
    if (request.contents && Array.isArray(request.contents)) {
      for (const content of request.contents) {
        if (content.role === 'user' && content.parts) {
          const text = content.parts
            .filter((part: any) => part.text)
            .map((part: any) => part.text)
            .join('');
          if (text) {
            messages.push({ role: 'user', content: text });
          }
        } else if (content.role === 'model' && content.parts) {
          const text = content.parts
            .filter((part: any) => part.text)
            .map((part: any) => part.text)
            .join('');
          if (text) {
            messages.push({ role: 'assistant', content: text });
          }
        }
      }
    }

    // 如果没有消息，添加一个默认的系统消息
    if (messages.length === 0) {
      messages.push({ role: 'system', content: 'You are a helpful assistant.' });
    }

    debugLog('🔍 Converted messages', { 
      messageCount: messages.length,
      roles: messages.map(m => m.role)
    }, 'DEBUG');

    return messages;
  }

  // 修正schema类型为小写
  private fixSchemaTypes(schema: any): any {
    if (typeof schema !== 'object' || schema === null) return schema;
    if (schema.type && typeof schema.type === 'string') {
      const upper = schema.type.toUpperCase();
      if ([
        'STRING', 'NUMBER', 'BOOLEAN', 'ARRAY', 'OBJECT', 'INTEGER'
      ].includes(upper)) {
        schema.type = upper.toLowerCase();
      }
    }
    // 递归修正子属性
    for (const key of Object.keys(schema)) {
      schema[key] = this.fixSchemaTypes(schema[key]);
    }
    return schema;
  }

  // 获取MCP工具定义
  private getMcpTools(): any[] {
    if (!this.toolRegistry) {
      debugLog('🔍 Tool registry not available', {}, 'WARN');
      return [];
    }

    const tools: any[] = [];
    const allTools = this.toolRegistry.getAllTools();
    
    debugLog(`🔍 Found ${allTools.length} total tools`, {}, 'INFO');
    
    for (const tool of allTools) {
      debugLog(`🔍 Processing tool: ${tool.name}`, { 
        description: tool.description?.substring(0, 100) + '...',
        hasSchema: !!tool.schema,
        hasParameters: !!tool.schema?.parameters
      }, 'DEBUG');
      
      if (tool.name && tool.description && tool.schema?.parameters) {
        const fixedParams = this.fixSchemaTypes(JSON.parse(JSON.stringify(tool.schema.parameters)));
        debugLog(`🔍 Adding tool ${tool.name}`, { 
          paramCount: Object.keys(fixedParams.properties || {}).length,
          requiredParams: fixedParams.required || []
        }, 'DEBUG');
        
        tools.push({
          type: 'function',
          function: {
            name: tool.name,
            description: tool.description,
            parameters: fixedParams
          }
        });
      } else {
        debugLog(`🔍 Skipping tool ${tool.name}`, { 
          hasName: !!tool.name,
          hasDescription: !!tool.description,
          hasSchema: !!tool.schema,
          hasParameters: !!tool.schema?.parameters
        }, 'WARN');
      }
    }

    debugLog(`🔍 Returning ${tools.length} MCP tools to DeepSeek`, {
      toolNames: tools.map(t => t.function.name)
    }, 'INFO');
    
    return tools;
  }

  // 增强的工具执行方法
  private async executeMcpTool(toolCall: any): Promise<any> {
    if (!this.toolRegistry) {
      throw new Error('Tool registry not available');
    }

    const toolName = toolCall.function.name;
    const tool = this.toolRegistry.getTool(toolName);
    
    if (!tool) {
      throw new Error(`Tool ${toolName} not found`);
    }

    let args = {};
    try {
      args = JSON.parse(toolCall.function.arguments);
      debugLog(`🔍 Parsed tool arguments for ${toolName}`, { args }, 'DEBUG');
    } catch (e) {
      debugLog(`🔍 Failed to parse tool arguments for ${toolName}`, { 
        arguments: toolCall.function.arguments,
        error: (e as Error).message 
      }, 'WARN');
      args = {};
    }

    // 验证参数
    if (tool.schema?.parameters?.properties) {
      const validationResult = this.validateToolArguments(args, tool.schema.parameters);
      if (!validationResult.isValid) {
        debugLog(`🔍 Tool argument validation failed for ${toolName}`, { 
          errors: validationResult.errors 
        }, 'WARN');
      }
    }

    // 创建一个AbortSignal用于工具执行
    const abortController = new AbortController();
    const startTime = Date.now();
    
    try {
      debugLog(`🔍 Executing tool: ${toolName}`, { args }, 'INFO');
      const result = await tool.execute(args, abortController.signal);
      const executionTime = Date.now() - startTime;
      
      debugLog(`🔍 Tool execution completed: ${toolName}`, { 
        executionTime,
        hasResult: !!result,
        resultType: typeof result?.returnDisplay
      }, 'INFO');
      
      return result;
         } catch (error) {
       const executionTime = Date.now() - startTime;
       debugLog(`🔍 Tool execution failed: ${toolName}`, { 
         executionTime,
         error: (error as Error).message 
       }, 'ERROR');
       throw error;
     }
  }

  // 验证工具参数
  private validateToolArguments(args: any, schema: any): { isValid: boolean; errors: string[] } {
    const errors: string[] = [];
    const properties = schema.properties || {};
    const required = schema.required || [];

    // 检查必需参数
    for (const requiredParam of required) {
      if (!(requiredParam in args)) {
        errors.push(`Missing required parameter: ${requiredParam}`);
      }
    }

    // 检查参数类型
    for (const [paramName, paramValue] of Object.entries(args)) {
      const paramSchema = properties[paramName];
      if (paramSchema && paramValue !== undefined) {
        const typeCheck = this.checkParameterType(paramValue, paramSchema);
        if (!typeCheck.isValid) {
          errors.push(`Invalid type for parameter ${paramName}: ${typeCheck.error}`);
        }
      }
    }

    return { isValid: errors.length === 0, errors };
  }

  // 检查参数类型
  private checkParameterType(value: any, schema: any): { isValid: boolean; error?: string } {
    const type = schema.type;
    
    switch (type) {
      case 'string':
        return typeof value === 'string' ? { isValid: true } : { isValid: false, error: 'Expected string' };
      case 'number':
      case 'integer':
        return typeof value === 'number' ? { isValid: true } : { isValid: false, error: 'Expected number' };
      case 'boolean':
        return typeof value === 'boolean' ? { isValid: true } : { isValid: false, error: 'Expected boolean' };
      case 'array':
        return Array.isArray(value) ? { isValid: true } : { isValid: false, error: 'Expected array' };
      case 'object':
        return typeof value === 'object' && value !== null ? { isValid: true } : { isValid: false, error: 'Expected object' };
      default:
        return { isValid: true }; // 未知类型，跳过验证
    }
  }

  async generateContent(request: any): Promise<GenerateContentResponse> {
    debugLog('🔍 generateContent method called', { 
      hasConfig: !!request.config,
      temperature: request.config?.temperature,
      maxTokens: request.config?.maxOutputTokens
    }, 'INFO');
    
    const messages = this.convertToDeepseekMessages(request);
    const tools = this.getMcpTools();
    
    debugLog(`🔍 Sending request to DeepSeek with ${tools.length} tools`, {
      toolNames: tools.map(t => t.function.name)
    }, 'INFO');
    
    const deepseekRequest: DeepseekRequest = {
      model: request.model || 'deepseek-chat',
      messages,
      stream: false,
      temperature: request.config?.temperature,
      max_tokens: request.config?.maxOutputTokens,
    };

    // 如果有MCP工具可用，添加到请求中
    if (tools.length > 0) {
      deepseekRequest.tools = tools;
      deepseekRequest.tool_choice = 'auto';
    }

    try {
      debugLog('🔍 Sending request to DeepSeek', { 
        model: deepseekRequest.model,
        messageCount: deepseekRequest.messages.length,
        hasTools: !!deepseekRequest.tools,
        toolCount: deepseekRequest.tools?.length || 0
      }, 'DEBUG');
      
      const response = await this.makeRequest('/v1/chat/completions', deepseekRequest);
      
      // 检查是否有工具调用
      const choice = response.choices[0];
      if (choice.message.tool_calls && choice.message.tool_calls.length > 0) {
        debugLog(`🔍 DeepSeek requested ${choice.message.tool_calls.length} tool calls`, {
          toolCallNames: choice.message.tool_calls.map((tc: any) => tc.function.name)
        }, 'INFO');
        
        // 执行工具调用
        const toolResults = [];
        for (const toolCall of choice.message.tool_calls) {
          try {
            debugLog(`🔍 Executing tool call: ${toolCall.function.name}`, {
              toolCallId: toolCall.id,
              arguments: toolCall.function.arguments
            }, 'INFO');
            
            const result = await this.executeMcpTool(toolCall);
            toolResults.push({
              tool_call_id: toolCall.id,
              role: 'tool',
              content: typeof result.returnDisplay === 'string' ? result.returnDisplay : JSON.stringify(result.returnDisplay)
            });
          } catch (error) {
            debugLog(`🔍 Error executing tool ${toolCall.function.name}`, { 
              error: (error as Error).message,
              toolCallId: toolCall.id 
            }, 'ERROR');
            
            toolResults.push({
              tool_call_id: toolCall.id,
              role: 'tool',
              content: `Error executing tool: ${(error as Error).message}`
            });
          }
        }

        // 如果有工具结果，发送第二次请求
        if (toolResults.length > 0) {
          debugLog('🔍 Sending follow-up request with tool results', {
            resultCount: toolResults.length,
            resultTypes: toolResults.map(r => typeof r.content)
          }, 'INFO');
          
          const followUpMessages = [...messages, choice.message, ...toolResults];
          const followUpRequest: DeepseekRequest = {
            model: request.model || 'deepseek-chat',
            messages: followUpMessages,
            stream: false,
            temperature: request.config?.temperature,
            max_tokens: request.config?.maxOutputTokens,
          };

          const followUpResponse = await this.makeRequest('/v1/chat/completions', followUpRequest);
          const finalChoice = followUpResponse.choices[0];
          
          debugLog('🔍 Follow-up response received', {
            hasContent: !!finalChoice.message.content,
            finishReason: finalChoice.finish_reason
          }, 'DEBUG');
          
          return {
            candidates: [{
              content: {
                parts: [{ text: finalChoice.message.content }]
              },
              finishReason: finalChoice.finish_reason === 'stop' ? 'STOP' : 'OTHER'
            }],
            usageMetadata: {
              promptTokenCount: followUpResponse.usage.prompt_tokens,
              candidatesTokenCount: followUpResponse.usage.completion_tokens,
              totalTokenCount: followUpResponse.usage.total_tokens
            },
            text: finalChoice.message.content
          } as GenerateContentResponse;
        }
      } else {
        debugLog('🔍 No tool calls in DeepSeek response', {
          hasContent: !!choice.message.content,
          finishReason: choice.finish_reason
        }, 'DEBUG');
      }
      
      return {
        candidates: [{
          content: {
            parts: [{ text: choice.message.content }]
          },
          finishReason: choice.finish_reason === 'stop' ? 'STOP' : 'OTHER'
        }],
        usageMetadata: {
          promptTokenCount: response.usage.prompt_tokens,
          candidatesTokenCount: response.usage.completion_tokens,
          totalTokenCount: response.usage.total_tokens
        },
        text: choice.message.content
      } as GenerateContentResponse;
    } catch (error) {
      debugLog('🔍 Deepseek API error', { error: (error as Error).message }, 'ERROR');
      throw error;
    }
  }

  async generateContentStream(request: any): Promise<AsyncGenerator<GenerateContentResponse>> {
    debugLog('🔍 generateContentStream method called', { 
      hasConfig: !!request.config,
      temperature: request.config?.temperature,
      maxTokens: request.config?.maxOutputTokens
    }, 'INFO');
    
    const messages = this.convertToDeepseekMessages(request);
    const tools = this.getMcpTools();
    
    debugLog(`🔍 Sending stream request to DeepSeek with ${tools.length} tools`, {
      toolNames: tools.map(t => t.function.name)
    }, 'INFO');
    
    const deepseekRequest: DeepseekRequest = {
      model: request.model || 'deepseek-chat',
      messages,
      stream: true,
      temperature: request.config?.temperature,
      max_tokens: request.config?.maxOutputTokens,
    };

    // 如果有MCP工具可用，添加到请求中
    if (tools.length > 0) {
      deepseekRequest.tools = tools;
      deepseekRequest.tool_choice = 'auto';
    }

    debugLog('🔍 Sending stream request to DeepSeek', { 
      model: deepseekRequest.model,
      messageCount: deepseekRequest.messages.length,
      hasTools: !!deepseekRequest.tools,
      toolCount: deepseekRequest.tools?.length || 0
    }, 'DEBUG');

    const self = this;
    return (async function* () {
      try {
        const response = await fetch(`${self.baseUrl}/v1/chat/completions`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${self.apiKey}`,
          },
          body: JSON.stringify(deepseekRequest),
        });

        if (!response.ok) {
          const errorText = await response.text();
          debugLog('🔍 DeepSeek API error response', { 
            status: response.status, 
            statusText: response.statusText, 
            error: errorText 
          }, 'ERROR');
          throw new Error(`Deepseek API error: ${response.status} ${response.statusText} - ${errorText}`);
        }

        const reader = response.body?.getReader();
        if (!reader) {
          throw new Error('Failed to get response reader');
        }

        const decoder = new TextDecoder();
        let buffer = '';
        let accumulatedContent = '';
        let toolCalls: any[] = [];
        let toolCallStates: Map<number, ToolCallState> = new Map();

        debugLog('🔍 Starting stream processing', {}, 'DEBUG');

        while (true) {
          const { done, value } = await reader.read();
          if (done) break;

          buffer += decoder.decode(value, { stream: true });
          const lines = buffer.split('\n');
          buffer = lines.pop() || '';

          for (const line of lines) {
            if (line.startsWith('data: ')) {
              const data = line.slice(6);
              if (data === '[DONE]') {
                debugLog('🔍 Stream completed', {
                  accumulatedContentLength: accumulatedContent.length,
                  toolCallCount: toolCalls.length
                }, 'INFO');
                
                // 检查是否有工具调用需要执行
                if (toolCalls.length > 0) {
                  debugLog(`🔍 Found ${toolCalls.length} tool calls to execute`, {
                    toolCallNames: toolCalls.map(tc => tc.function.name)
                  }, 'INFO');
                  
                  // 执行工具调用
                  const toolResults: DeepseekMessage[] = [];
                  for (const toolCall of toolCalls) {
                    try {
                      debugLog(`🔍 Executing tool call: ${toolCall.function.name}`, {
                        toolCallId: toolCall.id,
                        arguments: toolCall.function.arguments
                      }, 'INFO');
                      
                      const result = await self.executeMcpTool(toolCall);
                      toolResults.push({
                        tool_call_id: toolCall.id,
                        role: 'tool' as const,
                        content: typeof result.returnDisplay === 'string' ? result.returnDisplay : JSON.stringify(result.returnDisplay)
                      });
                    } catch (error) {
                      debugLog(`🔍 Error executing tool ${toolCall.function.name}`, { 
                        error: (error as Error).message,
                        toolCallId: toolCall.id 
                      }, 'ERROR');
                      
                      toolResults.push({
                        tool_call_id: toolCall.id,
                        role: 'tool' as const,
                        content: `Error executing tool: ${(error as Error).message}`
                      });
                    }
                  }

                  // 如果有工具结果，发送第二次请求
                  if (toolResults.length > 0) {
                    debugLog('🔍 Sending follow-up stream request with tool results', {
                      resultCount: toolResults.length,
                      resultTypes: toolResults.map(r => typeof r.content)
                    }, 'INFO');
                    
                    const followUpMessages: DeepseekMessage[] = [
                      ...messages, 
                      { 
                        role: 'assistant' as const, 
                        content: accumulatedContent, 
                        tool_calls: toolCalls 
                      },
                      ...toolResults
                    ];
                    
                    // 直接发送第二次请求而不是递归调用
                    const followUpRequest: DeepseekRequest = {
                      model: request.model || 'deepseek-chat',
                      messages: followUpMessages,
                      stream: true,
                      temperature: request.config?.temperature,
                      max_tokens: request.config?.maxOutputTokens,
                    };

                    debugLog('🔍 Sending follow-up request', {
                      model: followUpRequest.model,
                      messageCount: followUpRequest.messages.length
                    }, 'DEBUG');
                    
                    const followUpResponse = await fetch(`${self.baseUrl}/v1/chat/completions`, {
                      method: 'POST',
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${self.apiKey}`,
                      },
                      body: JSON.stringify(followUpRequest),
                    });

                    if (!followUpResponse.ok) {
                      const errorText = await followUpResponse.text();
                      throw new Error(`Deepseek follow-up API error: ${followUpResponse.status} ${followUpResponse.statusText} - ${errorText}`);
                    }

                    const followUpReader = followUpResponse.body?.getReader();
                    if (!followUpReader) {
                      throw new Error('Failed to get follow-up response reader');
                    }

                    const followUpDecoder = new TextDecoder();
                    let followUpBuffer = '';

                    debugLog('🔍 Processing follow-up stream', {}, 'DEBUG');

                    while (true) {
                      const { done, value } = await followUpReader.read();
                      if (done) break;

                      followUpBuffer += followUpDecoder.decode(value, { stream: true });
                      const followUpLines = followUpBuffer.split('\n');
                      followUpBuffer = followUpLines.pop() || '';

                      for (const followUpLine of followUpLines) {
                        if (followUpLine.startsWith('data: ')) {
                          const followUpData = followUpLine.slice(6);
                          if (followUpData === '[DONE]') {
                            debugLog('🔍 Follow-up stream completed', {}, 'DEBUG');
                            return;
                          }

                          try {
                            const followUpParsed: any = JSON.parse(followUpData);
                            if (followUpParsed.choices[0].delta.content) {
                              yield {
                                candidates: [{
                                  content: {
                                    parts: [{ text: followUpParsed.choices[0].delta.content }]
                                  }
                                }]
                              } as GenerateContentResponse;
                            }
                          } catch (e) {
                            debugLog('🔍 Error parsing follow-up stream chunk', { error: (e as Error).message }, 'WARN');
                          }
                        }
                      }
                    }
                  }
                }
                return;
              }

              try {
                const parsed: any = JSON.parse(data);
                
                if (parsed.choices[0].delta.content) {
                  accumulatedContent += parsed.choices[0].delta.content;
                  yield {
                    candidates: [{
                      content: {
                        parts: [{ text: parsed.choices[0].delta.content }]
                      }
                    }]
                  } as GenerateContentResponse;
                }
                
                // 处理工具调用
                if (parsed.choices[0].delta.tool_calls) {
                  debugLog('🔍 Tool call delta received', {
                    deltaCount: parsed.choices[0].delta.tool_calls.length,
                    indices: parsed.choices[0].delta.tool_calls.map((d: any) => d.index)
                  }, 'DEBUG');
                  
                  for (const toolCallDelta of parsed.choices[0].delta.tool_calls) {
                    const index = toolCallDelta.index;
                    if (index === undefined) continue;

                    let toolCall = toolCalls[index];
                    let toolCallState = toolCallStates.get(index);

                    if (!toolCall) {
                      // 创建新的工具调用
                      toolCall = {
                        id: toolCallDelta.id || '',
                        type: 'function',
                        function: {
                          name: toolCallDelta.function?.name || '',
                          arguments: toolCallDelta.function?.arguments || ''
                        }
                      };
                      toolCalls[index] = toolCall;
                      
                      toolCallState = {
                        id: toolCall.id,
                        name: toolCall.function.name,
                        arguments: toolCall.function.arguments,
                        isComplete: false,
                        startTime: Date.now()
                      };
                      toolCallStates.set(index, toolCallState);
                      
                      debugLog(`🔍 Created new tool call at index ${index}`, {
                        id: toolCall.id,
                        name: toolCall.function.name
                      }, 'DEBUG');
                    } else {
                      // 更新现有工具调用
                      if (toolCallDelta.function?.name) {
                        toolCall.function.name += toolCallDelta.function.name;
                        toolCallState!.name = toolCall.function.name;
                      }
                      if (toolCallDelta.function?.arguments) {
                        toolCall.function.arguments += toolCallDelta.function.arguments;
                        toolCallState!.arguments = toolCall.function.arguments;
                      }
                      
                      debugLog(`🔍 Updated tool call at index ${index}`, {
                        name: toolCall.function.name,
                        argumentsLength: toolCall.function.arguments.length
                      }, 'DEBUG');
                    }
                  }
                }
              } catch (e) {
                debugLog('🔍 Error parsing stream chunk', { error: (e as Error).message }, 'WARN');
              }
            }
          }
        }
      } catch (error) {
        debugLog('🔍 Deepseek stream error', { error: (error as Error).message }, 'ERROR');
        console.error('Deepseek stream error:', error);
        throw error;
      }
    })();
  }

  async countTokens(request: any): Promise<CountTokensResponse> {
    // Deepseek API 没有直接的 token 计数端点，返回估算值
    const text = request.contents?.[0]?.parts?.[0]?.text || '';
    return {
      totalTokens: Math.ceil(text.length / 4) // 粗略估算
    } as CountTokensResponse;
  }

  async embedContent(request: any): Promise<EmbedContentResponse> {
    throw new Error('Embedding not supported by Deepseek adapter');
  }
} 