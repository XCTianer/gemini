# 🔍 Gemini CLI 工具识别与调用机制详解

## 📋 概述

Gemini CLI 通过一套完整的工具注册、发现、识别和调用机制来扩展AI模型的能力。这个过程涉及多个组件协同工作，确保工具能够被正确识别、验证和执行。

## 🏗️ 工具识别流程

### 1. **工具注册阶段**

#### 工具发现 (Tool Discovery)
```typescript
// 在 ToolRegistry.discoverTools() 中
async discoverTools(): Promise<void> {
  // 1. 清理之前发现的工具
  for (const tool of this.tools.values()) {
    if (tool instanceof DiscoveredTool || tool instanceof DiscoveredMCPTool) {
      this.tools.delete(tool.name);
    }
  }
  
  // 2. 通过命令发现工具
  const discoveryCmd = this.config.getToolDiscoveryCommand();
  if (discoveryCmd) {
    const functions: FunctionDeclaration[] = [];
    for (const tool of JSON.parse(execSync(discoveryCmd).toString().trim())) {
      // 解析工具声明
      if (tool['function_declarations']) {
        functions.push(...tool['function_declarations']);
      } else if (tool['functionDeclarations']) {
        functions.push(...tool['functionDeclarations']);
      } else if (tool['name']) {
        functions.push(tool);
      }
    }
    
    // 注册每个发现的工具
    for (const func of functions) {
      this.registerTool(
        new DiscoveredTool(
          this.config,
          func.name!,
          func.description!,
          func.parameters! as Record<string, unknown>,
        ),
      );
    }
  }
  
  // 3. 通过MCP服务器发现工具
  await discoverMcpTools(
    this.config.getMcpServers() ?? {},
    this.config.getMcpServerCommand(),
    this,
  );
}
```

#### 工具注册 (Tool Registration)
```typescript
// 在 ToolRegistry.registerTool() 中
registerTool(tool: Tool): void {
  if (this.tools.has(tool.name)) {
    console.warn(
      `Tool with name "${tool.name}" is already registered. Overwriting.`,
    );
  }
  this.tools.set(tool.name, tool);
}
```

### 2. **工具识别阶段**

#### 获取工具声明 (Function Declarations)
```typescript
// 在 ToolRegistry.getFunctionDeclarations() 中
getFunctionDeclarations(): FunctionDeclaration[] {
  const declarations: FunctionDeclaration[] = [];
  this.tools.forEach((tool) => {
    declarations.push(tool.schema);
  });
  return declarations;
}
```

#### 发送给Gemini模型
```typescript
// 在非交互式CLI中
const responseStream = await chat.sendMessageStream({
  message: currentMessages[0]?.parts || [],
  config: {
    abortSignal: abortController.signal,
    tools: [
      { functionDeclarations: toolRegistry.getFunctionDeclarations() },
    ],
  },
});
```

### 3. **工具调用阶段**

#### 模型决策
Gemini模型基于以下信息决定是否调用工具：
- **用户输入**: 用户的原始请求
- **工具描述**: 每个工具的 `description` 字段
- **参数模式**: 工具的 `parameterSchema` 定义
- **上下文**: 对话历史和当前状态

#### 生成FunctionCall
```typescript
// Gemini模型返回的FunctionCall结构
interface FunctionCall {
  id?: string;
  name: string;        // 工具名称
  args: Record<string, unknown>;  // 工具参数
}
```

#### 工具查找
```typescript
// 在 executeToolCall() 中
const tool = toolRegistry.getTool(toolCallRequest.name);
if (!tool) {
  const error = new Error(
    `Tool "${toolCallRequest.name}" not found in registry.`,
  );
  // 处理工具未找到的错误
}
```

## 🔧 工具执行流程

### 1. **参数验证**
```typescript
// 在工具执行前进行参数验证
const validationError = tool.validateToolParams(params);
if (validationError) {
  return {
    llmContent: `Error: Invalid parameters provided. Reason: ${validationError}`,
    returnDisplay: validationError,
  };
}
```

### 2. **确认机制**
```typescript
// 检查是否需要用户确认
const confirmationDetails = await tool.shouldConfirmExecute(
  params,
  abortSignal,
);

if (confirmationDetails) {
  // 显示确认对话框
  // 等待用户选择：继续、总是允许、取消
}
```

### 3. **工具执行**
```typescript
// 执行工具
const toolResult: ToolResult = await tool.execute(
  params,
  abortSignal,
  liveOutputCallback,
);
```

### 4. **结果处理**
```typescript
// 转换结果为FunctionResponse格式
const response = convertToFunctionResponse(
  toolName,
  callId,
  toolResult.llmContent,
);

return {
  callId,
  responseParts: response,
  resultDisplay: toolResult.returnDisplay,
  error: undefined,
};
```

## 🎯 工具类型识别

### 1. **内置工具**
- **文件工具**: `read-file`, `edit`, `delete-file`
- **Shell工具**: `shell`
- **Web工具**: `web-fetch`, `web-search`
- **内存工具**: `memory`

### 2. **MCP工具**
- **标准MCP工具**: 直接返回结果
- **带摘要的MCP工具**: 自动生成LLM摘要

### 3. **发现工具**
- **项目工具**: 通过 `toolDiscoveryCommand` 发现
- **外部工具**: 通过MCP服务器发现

## 🔍 工具匹配机制

### 1. **名称匹配**
```typescript
// 精确匹配工具名称
const tool = toolRegistry.getTool(toolCallRequest.name);
```

### 2. **参数验证**
```typescript
// 验证参数是否符合工具模式
validateToolParams(params: TParams): string | null {
  // 检查必需参数
  // 验证参数类型
  // 检查参数范围
  return null; // 返回null表示验证通过
}
```

### 3. **描述匹配**
Gemini模型通过工具描述来理解工具功能：
```typescript
// 工具描述示例
description: "Reads the contents of a file from the filesystem. " +
  "The file path should be relative to the project root directory. " +
  "Returns the file contents as a string."
```

## 📊 工具状态跟踪

### 1. **执行状态**
```typescript
enum ToolCallStatus {
  VALIDATING = 'validating',
  AWAITING_APPROVAL = 'awaiting_approval',
  SCHEDULED = 'scheduled',
  EXECUTING = 'executing',
  SUCCESS = 'success',
  ERROR = 'error',
  CANCELLED = 'cancelled',
}
```

### 2. **MCP服务器状态**
```typescript
enum MCPServerStatus {
  DISCONNECTED = 'disconnected',
  CONNECTING = 'connecting',
  CONNECTED = 'connected',
}
```

## 🚀 性能优化

### 1. **工具缓存**
- 工具注册后缓存在 `ToolRegistry` 中
- 避免重复发现和注册

### 2. **并发执行**
- 多个工具可以并发执行
- 使用 `Promise.all()` 处理批量工具调用

### 3. **超时控制**
```typescript
// MCP工具默认超时10分钟
export const MCP_DEFAULT_TIMEOUT_MSEC = 10 * 60 * 1000;
```

## 🔧 调试和监控

### 1. **工具调用日志**
```typescript
logToolCall(config, {
  'event.name': 'tool_call',
  'event.timestamp': new Date().toISOString(),
  function_name: toolCallRequest.name,
  function_args: toolCallRequest.args,
  duration_ms: durationMs,
  success: true,
});
```

### 2. **错误处理**
- 工具未找到错误
- 参数验证错误
- 执行超时错误
- 网络连接错误

## 📝 总结

Gemini CLI的工具识别机制是一个多层次的系统：

1. **发现层**: 自动发现和注册可用工具
2. **识别层**: 将工具信息提供给AI模型
3. **匹配层**: 根据模型决策找到对应工具
4. **执行层**: 验证、确认、执行工具
5. **响应层**: 处理结果并返回给模型

这个机制确保了工具能够被正确识别、安全执行，并为AI模型提供扩展能力。 