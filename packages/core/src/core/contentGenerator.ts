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
  GoogleGenAI,
} from '@google/genai';
import { createCodeAssistContentGenerator } from '../code_assist/codeAssist.js';
import { DEFAULT_GEMINI_MODEL } from '../config/models.js';
import { getEffectiveModel } from './modelCheck.js';
import { DeepseekAdapter } from './deepseekAdapter.js';
import { ToolRegistry } from '../tools/tool-registry.js';
import { Config } from '../config/config.js';
import fs from 'fs';

/**
 * Interface abstracting the core functionalities for generating content and counting tokens.
 */
export interface ContentGenerator {
  generateContent(
    request: GenerateContentParameters,
  ): Promise<GenerateContentResponse>;

  generateContentStream(
    request: GenerateContentParameters,
  ): Promise<AsyncGenerator<GenerateContentResponse>>;

  countTokens(request: CountTokensParameters): Promise<CountTokensResponse>;

  embedContent(request: EmbedContentParameters): Promise<EmbedContentResponse>;
}

export enum AuthType {
  LOGIN_WITH_GOOGLE_PERSONAL = 'oauth-personal',
  USE_GEMINI = 'gemini-api-key',
  USE_VERTEX_AI = 'vertex-ai',
}

export type ContentGeneratorConfig = {
  model: string;
  apiKey?: string;
  vertexai?: boolean;
  authType?: AuthType | undefined;
};

export async function createContentGeneratorConfig(
  model: string | undefined,
  authType: AuthType | undefined,
  config?: { getModel?: () => string },
): Promise<ContentGeneratorConfig> {
  const geminiApiKey = process.env.GEMINI_API_KEY;
  const googleApiKey = process.env.GOOGLE_API_KEY;
  const googleCloudProject = process.env.GOOGLE_CLOUD_PROJECT;
  const googleCloudLocation = process.env.GOOGLE_CLOUD_LOCATION;

  // Use runtime model from config if available, otherwise fallback to parameter or default
  const effectiveModel = config?.getModel?.() || model || DEFAULT_GEMINI_MODEL;

  const contentGeneratorConfig: ContentGeneratorConfig = {
    model: effectiveModel,
    authType,
  };

  // if we are using google auth nothing else to validate for now
  if (authType === AuthType.LOGIN_WITH_GOOGLE_PERSONAL) {
    return contentGeneratorConfig;
  }

  if (authType === AuthType.USE_GEMINI && geminiApiKey) {
    contentGeneratorConfig.apiKey = geminiApiKey;
    contentGeneratorConfig.model = await getEffectiveModel(
      contentGeneratorConfig.apiKey,
      contentGeneratorConfig.model,
    );

    return contentGeneratorConfig;
  }

  if (
    authType === AuthType.USE_VERTEX_AI &&
    !!googleApiKey &&
    googleCloudProject &&
    googleCloudLocation
  ) {
    contentGeneratorConfig.apiKey = googleApiKey;
    contentGeneratorConfig.vertexai = true;
    contentGeneratorConfig.model = await getEffectiveModel(
      contentGeneratorConfig.apiKey,
      contentGeneratorConfig.model,
    );

    return contentGeneratorConfig;
  }

  return contentGeneratorConfig;
}

export async function createContentGenerator(
  config: ContentGeneratorConfig,
  toolRegistry?: ToolRegistry,
  appConfig?: Config,
): Promise<ContentGenerator> {
  const version = process.env.CLI_VERSION || process.version;
  const httpOptions = {
    headers: {
      'User-Agent': `GeminiCLI/${version} (${process.platform}; ${process.arch})`,
    },
  };

  // 从环境变量获取provider，默认为gemini
  const provider = process.env.GEMINI_PROVIDER || 'gemini';
  
  debugLog(`🔍 Debug: Provider = ${provider}, GEMINI_PROVIDER = ${process.env.GEMINI_PROVIDER}`);

  if (provider === 'deepseek') {
    const apiKey = process.env.DEEPSEEK_API_KEY;
    debugLog(`🔍 Debug: DEEPSEEK_API_KEY = ${apiKey ? 'SET' : 'NOT SET'}`);
    if (!apiKey) {
      throw new Error('DEEPSEEK_API_KEY environment variable is required for Deepseek provider');
    }
    debugLog('🔍 Debug: Using real Deepseek adapter');
    const adapter = new DeepseekAdapter(apiKey);
    
    // 如果提供了工具注册表和配置，设置到适配器中
    if (toolRegistry && appConfig) {
      adapter.setToolRegistry(toolRegistry, appConfig);
    }
    
    return adapter;
  }

  if (provider !== 'gemini') {
    // 返回一个模拟适配器
    return {
      async generateContent(request: any) {
        const responseText = `这是来自 ${provider} 的模拟响应。模型: ${request.model}`;
        return {
          candidates: [{
            content: {
              parts: [{ text: responseText }]
            },
            finishReason: 'STOP'
          }],
          usageMetadata: {
            promptTokenCount: 1,
            candidatesTokenCount: 1,
            totalTokenCount: 2
          },
          text: responseText
        } as GenerateContentResponse;
      },
      async generateContentStream(request: any) {
        const responseText = `这是来自 ${provider} 的流式模拟响应。模型: ${request.model}`;
        return (async function* () {
          const words = responseText.split(' ');
          for (const word of words) {
            yield {
              candidates: [{
                content: {
                  parts: [{ text: word + ' ' }]
                }
              }]
            };
            await new Promise(resolve => setTimeout(resolve, 100));
          }
        })();
      },
      async countTokens() { return { totalTokens: 1 }; },
      async embedContent() { throw new Error('Not implemented'); }
    } as ContentGenerator;
  }

  if (config.authType === AuthType.LOGIN_WITH_GOOGLE_PERSONAL) {
    return createCodeAssistContentGenerator(httpOptions, config.authType);
  }

  if (
    config.authType === AuthType.USE_GEMINI ||
    config.authType === AuthType.USE_VERTEX_AI
  ) {
    const googleGenAI = new GoogleGenAI({
      apiKey: config.apiKey === '' ? undefined : config.apiKey,
      vertexai: config.vertexai,
      httpOptions,
    });

    return googleGenAI.models;
  }

  throw new Error(
    `Error creating contentGenerator: Unsupported authType: ${config.authType}`,
  );
}

// 调试日志函数
function debugLog(msg: string, obj?: any) {
  const logEntry = msg + (obj ? ' ' + JSON.stringify(obj, null, 2) : '') + '\n';
  try {
    fs.appendFileSync('/tmp/gemini-debug.log', logEntry);
  } catch (error) {
    // 如果无法写入文件，尝试写入当前目录
    try {
      fs.appendFileSync('./gemini-debug.log', logEntry);
    } catch (e) {
      // 最后尝试写入stderr
      console.error(logEntry);
    }
  }
}
