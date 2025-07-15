# Gemini CLI 启动指南

## 快速启动

### 方法1：使用项目根目录的启动脚本
```bash
# 在项目根目录下
./gemini-cli --provider deepseek --model deepseek-chat
```

### 方法2：使用npm脚本
```bash
# 启动开发模式
npm start

# 启动调试模式
npm run debug

# 启动非交互模式（用于脚本）
npm run start:gcp
```

### 方法3：直接使用Node.js
```bash
# 使用CLI包
node packages/cli/dist/index.js --provider deepseek --model deepseek-chat

# 或使用构建后的bundle
node bundle/gemini.js --provider deepseek --model deepseek-chat
```

## 完整启动流程

### 1. 确保项目已构建
```bash
# 构建所有包
npm run build

# 或只构建CLI
npm run build:cli
```

### 2. 检查MCP服务器配置
确保 `.gemini/settings.json` 配置正确：
```json
{
  "selectedAuthType": "oauth-personal",
  "mcpServers": {
    "neo4j-graphrag": {
      "command": "/home/kotei/miniconda3/envs/sunny/bin/python",
      "args": [
        "/home/kotei/work/neo4j-graphrag-python/mcp_plugin/server.py"
      ],
      "cwd": "/home/kotei/work/neo4j-graphrag-python",
      "timeout": 300000,
      "trust": true,
      "env": {
        "MCP_SERVER_MODE": "true",
        "PYTHONUNBUFFERED": "1",
        "CONDA_DEFAULT_ENV": "sunny"
      }
    }
  }
}
```

### 3. 启动Gemini CLI
```bash
# 基本启动
./gemini-cli --provider deepseek --model deepseek-chat

# 启用调试模式
DEBUG=1 ./gemini-cli --provider deepseek --model deepseek-chat

# 指定系统提示文件
GEMINI_SYSTEM_MD=~/.gemini/system.md ./gemini-cli --provider deepseek --model deepseek-chat

# 禁用沙盒模式
GEMINI_SANDBOX=false ./gemini-cli --provider deepseek --model deepseek-chat
```

## 常用启动参数

### 模型相关
```bash
--provider deepseek          # 使用DeepSeek提供商
--model deepseek-chat        # 指定模型名称
--model deepseek-coder       # 使用代码专用模型
```

### 功能相关
```bash
--all-files                  # 包含所有文件到上下文
--yolo                       # 跳过工具确认（自动执行）
--show-memory-usage          # 显示内存使用情况
--checkpointing              # 启用检查点功能
```

### 调试相关
```bash
--debug                      # 启用调试模式
--verbose                    # 详细输出
--keep-output                # 保留输出文件
```

## 环境变量配置

### 基本配置
```bash
export GEMINI_PROVIDER=deepseek
export GEMINI_MODEL=deepseek-chat
export GEMINI_SYSTEM_MD=~/.gemini/system.md
export GEMINI_SANDBOX=false
```

### 调试配置
```bash
export DEBUG=1
export DEBUG_PORT=9229
export GEMINI_CLI_NO_RELAUNCH=true
```

### MCP相关
```bash
export MCP_SERVER_MODE=true
export PYTHONUNBUFFERED=1
```

## 验证启动成功

### 1. 检查MCP工具
启动后，使用 `/mcp` 命令检查MCP工具是否正确加载：
```
/mcp
```

预期输出：
```
MCP Servers Status:

📡 neo4j-graphrag (CONNECTED)
  Command: /home/kotei/miniconda3/envs/sunny/bin/python /home/kotei/work/neo4j-graphrag-python/mcp_plugin/server.py
  Working Directory: /home/kotei/work/neo4j-graphrag-python
  Timeout: 300000ms
  Tools: analyze_code_changes, get_impact_chains, get_file_impact

Discovery State: COMPLETED
```

### 2. 测试工具功能
尝试使用MCP工具：
```
使用analyze_code_changes分析代码变更
```

### 3. 检查工具响应格式
工具应该返回包含摘要的格式：
```
🔧 Tool analyze_code_changes executed:

```json
{
  "content": [
    {
      "type": "text",
      "text": "分析完成..."
    }
  ]
}
```

## 🔧 工具执行结果

**工具名称**: analyze_code_changes (neo4j-graphrag)
**执行时间**: 2024-01-15 14:30:25
**执行状态**: 成功

**结果摘要**:
分析完成，发现了3个关键问题...

**完整结果**: 请查看上方的详细输出。

---
*此工具已成功执行，您可以继续提问或要求进一步分析结果。*
```

## 故障排除

### 常见启动问题

1. **构建错误**
   ```bash
   # 清理并重新构建
   npm run clean
   npm run build
   ```

2. **MCP服务器连接失败**
   ```bash
   # 检查服务器配置
   cat .gemini/settings.json
   
   # 手动测试MCP服务器
   /home/kotei/miniconda3/envs/sunny/bin/python /home/kotei/work/neo4j-graphrag-python/mcp_plugin/server.py
   ```

3. **权限问题**
   ```bash
   # 确保启动脚本有执行权限
   chmod +x gemini-cli
   
   # 检查文件权限
   ls -la gemini-cli
   ```

4. **模型提供商问题**
   ```bash
   # 检查提供商配置
   ./gemini-cli --help
   
   # 尝试不同的提供商
   ./gemini-cli --provider openai --model gpt-4
   ```

### 调试模式启动
```bash
# 启用详细调试
DEBUG=1 GEMINI_SANDBOX=false ./gemini-cli --provider deepseek --model deepseek-chat

# 查看启动日志
DEBUG=1 npm start 2>&1 | tee startup.log
```

## 启动脚本示例

### 创建便捷启动脚本
```bash
# 创建 ~/bin/start-gemini.sh
#!/bin/bash
cd /home/kotei/work/nj/gemini-cli
export GEMINI_PROVIDER=deepseek
export GEMINI_MODEL=deepseek-chat
export GEMINI_SANDBOX=false
./gemini-cli "$@"
```

```bash
# 设置权限并添加到PATH
chmod +x ~/bin/start-gemini.sh
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 使用
start-gemini.sh
```

### 创建开发环境启动脚本
```bash
# 创建 ~/bin/gemini-dev.sh
#!/bin/bash
cd /home/kotei/work/nj/gemini-cli
export DEBUG=1
export GEMINI_SANDBOX=false
export GEMINI_PROVIDER=deepseek
export GEMINI_MODEL=deepseek-chat
npm run debug
```

## 总结

启动Gemini CLI的基本步骤：

1. **构建项目**：`npm run build`
2. **配置MCP服务器**：编辑 `.gemini/settings.json`
3. **启动CLI**：`./gemini-cli --provider deepseek --model deepseek-chat`
4. **验证功能**：使用 `/mcp` 和工具测试

现在你可以在Gemini CLI中使用你的通用MCP工具了！ 