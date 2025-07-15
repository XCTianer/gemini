# 🚀 Gemini CLI 快速启动指南

## 一键启动

### 方法1：使用便捷启动脚本（推荐）
```bash
# 在项目根目录下
./start-gemini.sh
```

### 方法2：直接启动
```bash
# 基本启动
./gemini-cli --provider deepseek --model deepseek-chat

# 或使用npm脚本
npm start
```

## 启动前检查清单

### ✅ 1. 确保项目已构建
```bash
npm run build
```

### ✅ 2. 检查MCP配置
确保 `.gemini/settings.json` 存在且配置正确：
```bash
cat .gemini/settings.json
```

### ✅ 3. 检查启动脚本权限
```bash
chmod +x gemini-cli
chmod +x start-gemini.sh
```

## 启动后验证

### 1. 检查MCP工具状态
在Gemini CLI中输入：
```
/mcp
```

应该看到类似输出：
```
MCP Servers Status:

📡 neo4j-graphrag (CONNECTED)
  Tools: analyze_code_changes, get_impact_chains, get_file_impact

Discovery State: COMPLETED
```

### 2. 测试工具功能
尝试使用MCP工具：
```
使用analyze_code_changes分析代码变更
```

### 3. 验证通用格式
工具应该返回包含摘要的格式，支持Continue继续对话。

## 常见问题解决

### ❌ 构建失败
```bash
npm run clean
npm run build
```

### ❌ MCP服务器连接失败
```bash
# 检查服务器配置
cat .gemini/settings.json

# 手动测试MCP服务器
/home/kotei/miniconda3/envs/sunny/bin/python /home/kotei/work/neo4j-graphrag-python/mcp_plugin/server.py
```

### ❌ 权限问题
```bash
chmod +x gemini-cli
chmod +x start-gemini.sh
```

### ❌ 模型提供商问题
```bash
# 尝试不同的提供商
./gemini-cli --provider openai --model gpt-4
./gemini-cli --provider gemini --model gemini-2.5-pro
```

## 调试模式启动

### 启用详细调试
```bash
DEBUG=1 ./start-gemini.sh
```

### 查看启动日志
```bash
DEBUG=1 npm start 2>&1 | tee startup.log
```

## 环境变量配置

### 设置默认配置
```bash
export GEMINI_PROVIDER=deepseek
export GEMINI_MODEL=deepseek-chat
export GEMINI_SANDBOX=false
```

### 添加到 ~/.bashrc
```bash
echo 'export GEMINI_PROVIDER=deepseek' >> ~/.bashrc
echo 'export GEMINI_MODEL=deepseek-chat' >> ~/.bashrc
echo 'export GEMINI_SANDBOX=false' >> ~/.bashrc
source ~/.bashrc
```

## 使用示例

### 启动后可以：
1. **查看MCP工具**：`/mcp`
2. **使用分析工具**：`使用analyze_code_changes分析代码变更`
3. **继续对话**：基于工具结果继续提问
4. **查看帮助**：`/help`

### 预期体验：
- ✅ Gemini CLI中正常显示工具结果
- ✅ Continue中可以基于摘要继续对话
- ✅ 统一的用户体验

## 总结

**最简单的启动方式**：
```bash
./start-gemini.sh
```

**完整的启动流程**：
1. `npm run build` - 构建项目
2. `./start-gemini.sh` - 启动CLI
3. `/mcp` - 验证MCP工具
4. 使用工具并享受统一体验！

现在你的MCP工具可以在Gemini和Continue中无缝使用了！🎉 