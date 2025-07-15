/**
 * @license
 * Copyright 2025 Google LLC
 * SPDX-License-Identifier: Apache-2.0
 */

import {
  BaseTool,
  ToolResult,
  ToolCallConfirmationDetails,
  ToolConfirmationOutcome,
  ToolMcpConfirmationDetails,
} from './tools.js';
import { CallableTool, Part, FunctionCall } from '@google/genai';
import { Config } from '../config/config.js';

type ToolParams = Record<string, unknown>;

/**
 * Enhanced MCP Tool that automatically generates structured summaries after execution
 * This implements Solution 1: Modify CLI code to automatically generate summaries
 */
export class DiscoveredMCPToolWithSummary extends BaseTool<ToolParams, ToolResult> {
  private static readonly allowlist: Set<string> = new Set();

  constructor(
    private readonly mcpTool: CallableTool,
    readonly serverName: string,
    readonly name: string,
    readonly description: string,
    readonly parameterSchema: Record<string, unknown>,
    readonly serverToolName: string,
    readonly timeout?: number,
    readonly trust?: boolean,
    private readonly config?: Config,
  ) {
    super(
      name,
      `${serverToolName} (${serverName} MCP Server)`,
      description,
      parameterSchema,
      true, // isOutputMarkdown
      false, // canUpdateOutput
    );
  }

  async shouldConfirmExecute(
    _params: ToolParams,
    _abortSignal: AbortSignal,
  ): Promise<ToolCallConfirmationDetails | false> {
    const serverAllowListKey = this.serverName;
    const toolAllowListKey = `${this.serverName}.${this.serverToolName}`;

    if (this.trust) {
      return false; // server is trusted, no confirmation needed
    }

    if (
      DiscoveredMCPToolWithSummary.allowlist.has(serverAllowListKey) ||
      DiscoveredMCPToolWithSummary.allowlist.has(toolAllowListKey)
    ) {
      return false; // server and/or tool already allow listed
    }

    const confirmationDetails: ToolMcpConfirmationDetails = {
      type: 'mcp',
      title: 'Confirm MCP Tool Execution',
      serverName: this.serverName,
      toolName: this.serverToolName, // Display original tool name in confirmation
      toolDisplayName: this.name, // Display global registry name exposed to model and user
      onConfirm: async (outcome: ToolConfirmationOutcome) => {
        if (outcome === ToolConfirmationOutcome.ProceedAlwaysServer) {
          DiscoveredMCPToolWithSummary.allowlist.add(serverAllowListKey);
        } else if (outcome === ToolConfirmationOutcome.ProceedAlwaysTool) {
          DiscoveredMCPToolWithSummary.allowlist.add(toolAllowListKey);
        }
      },
    };
    return confirmationDetails;
  }

  async execute(params: ToolParams): Promise<ToolResult> {
    const functionCalls: FunctionCall[] = [
      {
        name: this.serverToolName,
        args: params,
      },
    ];

    const responseParts: Part[] = await this.mcpTool.callTool(functionCalls);

    // 添加调试输出，查看MCP工具的实际输出格式
    const debugOutput = `=== MCP Tool Debug Output ===
Tool Name: ${this.name}
Server Name: ${this.serverName}
Response Parts: ${JSON.stringify(responseParts, null, 2)}

`;
    
    const resultDisplay = getStringifiedResultForDisplay(responseParts);
    const fullDebugOutput = debugOutput + `Result Display: ${resultDisplay}
=== End Debug Output ===

`;
    
    // 写入到文件
    try {
      const fs = await import('fs');
      fs.writeFileSync('test_output.txt', fullDebugOutput, 'utf8');
      console.log('Debug output written to test_output.txt');
    } catch (error) {
      console.log('Failed to write debug output to file:', error);
    }

    // 检查是否需要生成摘要
    if (this.shouldGenerateSummary()) {
      const summaryPrompt = this.generateSummaryPrompt(resultDisplay);
      
      // 尝试调用Gemini LLM进行实际分析
      try {
        const llmAnalysis = await this.generateLLMAnalysis(resultDisplay, summaryPrompt);
        
        // 将LLM分析结果也写入文件
        const llmOutput = `LLM Analysis: ${llmAnalysis}
=== End LLM Analysis ===

`;
        try {
          const fs = await import('fs');
          fs.appendFileSync('test_output.txt', llmOutput, 'utf8');
        } catch (error) {
          console.log('Failed to append LLM analysis to file:', error);
        }
        
        // Create enhanced result with LLM analysis
        const enhancedResult: ToolResult = {
          llmContent: [
            ...responseParts,
            { text: '\n\n' + llmAnalysis }
          ],
          returnDisplay: resultDisplay + '\n\n' + llmAnalysis,
        };

        return enhancedResult;
      } catch (error) {
        console.warn(`Failed to generate LLM analysis for ${this.name}:`, error);
        
        // Fallback to template-only approach
        const enhancedResult: ToolResult = {
          llmContent: [
            ...responseParts,
            { text: '\n\n' + summaryPrompt }
          ],
          returnDisplay: resultDisplay + '\n\n' + summaryPrompt,
        };

        return enhancedResult;
      }
    }

    return {
      llmContent: responseParts,
      returnDisplay: resultDisplay,
    };
  }

  /**
   * Determines if this tool should generate a summary
   */
  private shouldGenerateSummary(): boolean {
    const analysisTools = [
      'analyze_code_changes',
      'get_impact_chains',
      'get_file_impact',
      'get_commit_analysis',
      'get_neo4j_queries',
      'get_direct_mode_status',
      'code_analysis',
      'impact_analysis',
      'analyze',
      'analysis'
    ];

    return analysisTools.some(toolName => 
      this.serverToolName.toLowerCase().includes(toolName) ||
      this.name.toLowerCase().includes(toolName)
    );
  }

  /**
   * Generates a summary prompt based on the tool result
   */
  private generateSummaryPrompt(resultDisplay: string): string {
    const timestamp = new Date().toLocaleString('zh-CN', {
      timeZone: 'Asia/Shanghai',
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });

    return `## 🔍 代码变更影响分析报告

### 📊 分析概览
- **分析类型**: ${this.name} (${this.serverName} MCP服务器)
- **分析时间**: ${timestamp}
- **分析目标**: 对工作区git的变更代码进行深入分析，综合整个项目代码的实现逻辑来判断变更点是否存在问题

### 🎯 分析要求
请对工作区git的变更代码进行深入分析，需要综合整个项目代码的实现逻辑来判断变更点是否存在问题，问题包含以下几个方面：
- 变更代码可能直接引起BUG
- 变更代码对信号/逻辑关联的脚本引发BUG
- 变更代码对信号/逻辑关联的脚本引发非预期的结果
- 变更代码未能实现变更需求的预期效果
- 遗漏了其他需要修改的代码

### 📋 输出格式要求
请按照以下指定格式提供结构化反馈：

## 变更点定位
\`\`\`bash
[粘贴完整的git diff片段]
\`\`\`

## 审查清单
### 审查1
**审车代码位置：\`[文件路径] [行号范围]\`**
\`\`\`matlab
[粘贴需要人工审查的核心代码片段]
\`\`\`

**风险类别[请选择风险类别]**
    - 变更代码可能直接引起BUG
    - 变更代码对信号/逻辑关联的脚本引发BUG
    - 变更代码对信号/逻辑关联的脚本引发非预期的结果
    - 变更代码未能实现变更需求的预期效果
    - 遗漏了其他需要修改的代码

**影响链路**：
[如果风险类别为\`变更代码可能直接引起BUG\`或\`变更代码对信号/逻辑关联的脚本引发BUG\`，则填写影响链路]

**风险原因**：
[根据风险类别填写风险原因的详细内容]

** 修改建议**：
\`\`\`matlab
[完成建议修改后的代码]
\`\`\`

### 审查2
**审车代码位置：\`[文件路径] [行号范围]\`**
\`\`\`matlab
[粘贴需要人工审查的核心代码片段]
\`\`\`

**风险类别[请选择风险类别]**
    - 变更代码可能直接引起BUG
    - 变更代码对信号/逻辑关联的脚本引发BUG
    - 变更代码对信号/逻辑关联的脚本引发非预期的结果
    - 变更代码未能实现变更需求的预期效果
    - 遗漏了其他需要修改的代码

**影响链路**：
[如果风险类别为\`变更代码可能直接引起BUG\`或\`变更代码对信号/逻辑关联的脚本引发BUG\`，则填写影响链路]

**风险原因**：
[根据风险类别填写风险原因的详细内容]

** 修改建议**：
\`\`\`matlab
[完成建议修改后的代码]
\`\`\`

### 审查3
**审车代码位置：\`[文件路径] [行号范围]\`**
\`\`\`matlab
[粘贴需要人工审查的核心代码片段]
\`\`\`

**风险类别[请选择风险类别]**
    - 变更代码可能直接引起BUG
    - 变更代码对信号/逻辑关联的脚本引发BUG
    - 变更代码对信号/逻辑关联的脚本引发非预期的结果
    - 变更代码未能实现变更需求的预期效果
    - 遗漏了其他需要修改的代码

**影响链路**：
[如果风险类别为\`变更代码可能直接引起BUG\`或\`变更代码对信号/逻辑关联的脚本引发BUG\`，则填写影响链路]

**风险原因**：
[根据风险类别填写风险原因的详细内容]

** 修改建议**：
\`\`\`matlab
[完成建议修改后的代码]
\`\`\`

### 审查4
**审车代码位置：\`[文件路径] [行号范围]\`**
\`\`\`matlab
[粘贴需要人工审查的核心代码片段]
\`\`\`

**风险类别[请选择风险类别]**
    - 变更代码可能直接引起BUG
    - 变更代码对信号/逻辑关联的脚本引发BUG
    - 变更代码对信号/逻辑关联的脚本引发非预期的结果
    - 变更代码未能实现变更需求的预期效果
    - 遗漏了其他需要修改的代码

**影响链路**：
[如果风险类别为\`变更代码可能直接引起BUG\`或\`变更代码对信号/逻辑关联的脚本引发BUG\`，则填写影响链路]

**风险原因**：
[根据风险类别填写风险原因的详细内容]

** 修改建议**：
\`\`\`matlab
[完成建议修改后的代码]
\`\`\`

### 📝 输出格式说明及要求：
1. 只返回高风险的需要人工审查的代码，修改正确的或低风险的代码不需要返回
2. 根据实际发现的问题数量，可以少于4个审查项，也可以超过4个审查项
3. 每个审查项必须包含完整的风险分析、影响链路（如适用）和修改建议
4. 代码片段必须准确标注文件路径和行号范围

---
**分析数据**: 
\`\`\`json
${resultDisplay}
\`\`\`

请根据上述MCP工具返回的具体分析数据，生成详细的代码审查报告。确保分析准确、具体且可操作，重点关注高风险问题。`;
  }

  /**
   * Generates LLM analysis using Gemini
   */
  private async generateLLMAnalysis(originalData: string, analysisPrompt: string): Promise<string> {
    try {
      // 检查是否有配置和Gemini客户端
      if (!this.config) {
        throw new Error('Config not available for LLM analysis');
      }

      const geminiClient = this.config.getGeminiClient();
      if (!geminiClient) {
        throw new Error('Gemini client not available');
      }

      const analysisRequest = `你是一个专业的代码审查专家，请对以下MCP工具的输出结果进行分析。

## 重要说明
以下数据是MCP工具的输出结果。请首先判断这是否为真实的Neo4j查询数据，还是模板文本。

## 数据识别指导
1. **检查是否为模板文本**：如果数据包含"请基于以下代码变更影响分析数据，严格按照系统文档格式生成结构化分析报告"等模板语言，说明这是模板而不是真实数据
2. **检查是否为真实查询结果**：真实数据应该包含具体的文件路径、行号、变量名、依赖关系等详细信息
3. **识别数据来源**：区分是neo4j-graphrag的实际查询结果，还是工具生成的模板

## 分析重点
请重点关注以下几个方面的问题：
1. 变更代码可能直接引起BUG
2. 变更代码对信号/逻辑关联的脚本引发BUG
3. 变更代码对信号/逻辑关联的脚本引发非预期的结果
4. 变更代码未能实现变更需求的预期效果
5. 遗漏了其他需要修改的代码

## 原始MCP工具输出数据
${originalData}

## 分析要求
${analysisPrompt}

## 输出要求
请严格按照指定的格式输出，确保：
- **如果识别出这是模板文本**：请明确说明"检测到模板文本，无法进行实际分析"，并建议检查MCP工具配置
- **如果是真实的Neo4j查询数据**：请基于实际数据进行分析
- **如果数据为空或无效**：请说明"未获取到有效的查询数据"，并分析可能的原因
- 只返回高风险的需要人工审查的代码
- 每个审查项包含完整的风险分析、影响链路和修改建议
- 代码片段准确标注文件路径和行号范围
- 重点关注可能导致系统故障或安全问题的变更

## 特殊情况处理
如果检测到模板文本或无效数据，可能的原因：
1. MCP工具配置问题：neo4j-graphrag可能没有正确连接到数据库
2. 查询参数问题：传递的参数可能不正确
3. 数据库状态问题：Neo4j数据库可能没有该仓库的数据
4. 工具执行问题：MCP工具可能返回了默认模板而不是实际查询结果

请确保分析准确、具体且可操作，重点关注高风险问题。`;

      const response = await geminiClient.generateContent(
        [{ role: 'user', parts: [{ text: analysisRequest }] }],
        { temperature: 0.1, maxOutputTokens: 4000 },
        new AbortController().signal
      );

      const analysisText = response.candidates?.[0]?.content?.parts?.[0]?.text;
      if (!analysisText) {
        throw new Error('No analysis text generated');
      }

      return analysisText;
    } catch (error) {
      console.error('LLM analysis failed:', error);
      // 返回原始模板作为fallback
      return analysisPrompt;
    }
  }
}

/**
 * Processes an array of `Part` objects, primarily from a tool's execution result,
 * to generate a user-friendly string representation, typically for display in a CLI.
 */
function getStringifiedResultForDisplay(result: Part[]) {
  if (!result || result.length === 0) {
    return '```json\n[]\n```';
  }

  const processFunctionResponse = (part: Part) => {
    if (part.functionResponse) {
      const responseContent = part.functionResponse.response?.content;
      if (responseContent && Array.isArray(responseContent)) {
        // Check if all parts in responseContent are simple TextParts
        const allTextParts = responseContent.every(
          (p: Part) => p.text !== undefined,
        );
        if (allTextParts) {
          return responseContent.map((p: Part) => p.text).join('');
        }
        // If not all simple text parts, return the array of these content parts for JSON stringification
        return responseContent;
      }

      // If no content, or not an array, or not a functionResponse, stringify the whole functionResponse part for inspection
      return part.functionResponse;
    }
    return part; // Fallback for unexpected structure or non-FunctionResponsePart
  };

  const processedResults =
    result.length === 1
      ? processFunctionResponse(result[0])
      : result.map(processFunctionResponse);
  if (typeof processedResults === 'string') {
    return processedResults;
  }

  return '```json\n' + JSON.stringify(processedResults, null, 2) + '\n```';
}