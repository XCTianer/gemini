# 🔍 Gemini CLI 工具输出格式对比分析

## 📋 概述

Gemini CLI 中的不同工具返回的结果格式并不完全一样。虽然所有工具都遵循 `ToolResult` 接口，但具体的输出内容和格式会根据工具类型和功能而有所不同。

## 🏗️ 基础接口结构

所有工具都返回 `ToolResult` 接口：

```typescript
interface ToolResult {
  llmContent: PartListUnion;    // 用于LLM历史记录的内容
  returnDisplay: ToolResultDisplay;  // 用于用户显示的内容
}

type ToolResultDisplay = string | FileDiff;
```

## 🔧 不同工具的输出格式对比

### 1. **MCP工具 (DiscoveredMCPTool)**

**标准MCP工具**:
```json
{
  "llmContent": [
    {
      "functionResponse": {
        "name": "tool_name",
        "response": {
          "content": [
            { "text": "工具返回的文本内容" }
          ]
        }
      }
    }
  ],
  "returnDisplay": "工具返回的文本内容"
}
```

**带摘要的MCP工具**:
```json
{
  "llmContent": [
    {
      "functionResponse": {
        "name": "analyze_code_changes",
        "response": {
          "content": [
            { "text": "分析结果内容..." }
          ]
        }
      }
    },
    {
      "text": "\n\n## 🔍 MCP工具分析结果总结\n\n### 📊 分析概览..."
    }
  ],
  "returnDisplay": "分析结果内容...\n\n## 🔍 MCP工具分析结果总结..."
}
```

### 2. **文件读取工具 (ReadFileTool)**

```json
{
  "llmContent": "文件内容或错误信息",
  "returnDisplay": "用户友好的显示内容"
}
```

**成功示例**:
```json
{
  "llmContent": "function example() {\n  console.log('Hello World');\n}",
  "returnDisplay": "```javascript\nfunction example() {\n  console.log('Hello World');\n}\n```"
}
```

**错误示例**:
```json
{
  "llmContent": "Error: Invalid parameters provided. Reason: File path must be absolute",
  "returnDisplay": "File path must be absolute"
}
```

### 3. **文件编辑工具 (EditTool)**

**成功创建新文件**:
```json
{
  "llmContent": "Created new file: /path/to/file.txt with provided content.",
  "returnDisplay": "Created src/components/Button.tsx"
}
```

**成功修改文件**:
```json
{
  "llmContent": "Successfully modified file: /path/to/file.txt (1 replacements).",
  "returnDisplay": {
    "fileDiff": "--- a/file.txt\n+++ b/file.txt\n@@ -1,3 +1,3 @@\n-old content\n+new content",
    "fileName": "file.txt"
  }
}
```

**错误示例**:
```json
{
  "llmContent": "Error preparing edit: File not found",
  "returnDisplay": "Error preparing edit: File not found"
}
```

### 4. **Shell命令工具 (ShellTool)**

**成功执行**:
```json
{
  "llmContent": "Command: ls -la\nDirectory: (root)\nStdout: total 1234\ndrwxr-xr-x  user group 4096 Jan 27 14:30 .\nStderr: (empty)\nError: (none)\nExit Code: 0\nSignal: (none)\nBackground PIDs: (none)\nProcess Group PGID: 12345",
  "returnDisplay": "total 1234\ndrwxr-xr-x  user group 4096 Jan 27 14:30 ."
}
```

**调试模式**:
```json
{
  "llmContent": "Command: ls -la\nDirectory: (root)\nStdout: total 1234\nStderr: (empty)\nError: (none)\nExit Code: 0\nSignal: (none)\nBackground PIDs: (none)\nProcess Group PGID: 12345",
  "returnDisplay": "Command: ls -la\nDirectory: (root)\nStdout: total 1234\nStderr: (empty)\nError: (none)\nExit Code: 0\nSignal: (none)\nBackground PIDs: (none)\nProcess Group PGID: 12345"
}
```

**错误执行**:
```json
{
  "llmContent": "Command: invalid_command\nDirectory: (root)\nStdout: (empty)\nStderr: invalid_command: command not found\nError: (none)\nExit Code: 127\nSignal: (none)\nBackground PIDs: (none)\nProcess Group PGID: 12345",
  "returnDisplay": "Command exited with code: 127"
}
```

### 5. **Web搜索工具 (WebSearchTool)**

```json
{
  "llmContent": "搜索结果内容...",
  "returnDisplay": "搜索结果内容..."
}
```

### 6. **Grep搜索工具 (GrepTool)**

```json
{
  "llmContent": "搜索结果内容...",
  "returnDisplay": "搜索结果内容..."
}
```

## 🔍 关键差异分析

### 1. **llmContent 字段差异**

| 工具类型 | llmContent 格式 | 特点 |
|---------|----------------|------|
| MCP工具 | `Part[]` 数组 | 包含 functionResponse 结构 |
| 文件工具 | `string` | 直接文本内容 |
| Shell工具 | `string` | 结构化命令执行信息 |
| 编辑工具 | `string` | 操作结果描述 |

### 2. **returnDisplay 字段差异**

| 工具类型 | returnDisplay 格式 | 特点 |
|---------|------------------|------|
| 标准工具 | `string` | 用户友好的文本 |
| 编辑工具 | `FileDiff \| string` | 可能包含差异信息 |
| MCP工具 | `string` | 处理后的文本内容 |

### 3. **错误处理差异**

| 工具类型 | 错误格式 | 特点 |
|---------|---------|------|
| 所有工具 | `llmContent: "Error: ..."` | 详细错误信息 |
| 所有工具 | `returnDisplay: "Error: ..."` | 用户友好错误信息 |

### 4. **特殊格式处理**

#### **FileDiff 格式 (编辑工具)**
```typescript
interface FileDiff {
  fileDiff: string;  // Git风格的差异内容
  fileName: string;  // 文件名
}
```

#### **MCP FunctionResponse 格式**
```typescript
{
  functionResponse: {
    name: string;
    response: {
      content: Part[];
    };
  };
}
```

## 📊 输出格式选择逻辑

### 1. **MCP工具选择**
```javascript
function shouldUseSummaryTool(toolName: string): boolean {
  const analysisTools = [
    "analyze_code_changes", "get_impact_chains", 
    "get_file_impact", "get_commit_analysis",
    "code_analysis", "impact_analysis", 
    "analyze", "analysis"
  ];
  return analysisTools.some(analysisTool => 
    toolName.toLowerCase().includes(analysisTool)
  );
}
```

### 2. **显示模式选择**
- **调试模式**: `returnDisplay` 显示详细信息
- **正常模式**: `returnDisplay` 显示用户友好信息

### 3. **内容处理逻辑**
- **简单文本**: 直接返回
- **复杂结构**: JSON字符串化
- **差异信息**: 特殊FileDiff格式

## 🎯 总结

不同工具的输出格式差异主要体现在：

1. **MCP工具**: 使用特殊的 `functionResponse` 结构
2. **文件工具**: 直接文本内容，支持markdown格式
3. **Shell工具**: 结构化命令执行信息
4. **编辑工具**: 支持差异显示的特殊格式
5. **错误处理**: 统一的错误格式但内容详细程度不同

这种设计确保了：
- **兼容性**: 所有工具都遵循统一的接口
- **灵活性**: 不同工具可以根据需要定制输出格式
- **用户体验**: 提供用户友好的显示内容
- **调试支持**: 保留详细的调试信息 