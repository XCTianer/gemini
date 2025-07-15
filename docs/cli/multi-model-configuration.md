# 多模型配置

Gemini CLI 现在支持多种AI模型提供商，包括 Gemini、Deepseek、本地 DeepSeek 等。

## 支持的提供商

### Gemini (默认)
- **提供商名称**: `gemini`
- **环境变量**: `GEMINI_API_KEY`
- **认证类型**: API Key

### Deepseek
- **提供商名称**: `deepseek`
- **环境变量**: `DEEPSEEK_API_KEY`
- **认证类型**: API Key
- **API端点**: https://api.deepseek.com

### 本地 DeepSeek
- **提供商名称**: `local-deepseek`
- **环境变量**: `DEEPSEEK_API_KEY` (可选), `DEEPSEEK_BASE_URL`, `DEEPSEEK_TIMEOUT`
- **认证类型**: API Key (可选)
- **API端点**: 自定义 (默认 http://localhost:8000)
- **特点**: 支持本地部署的 DeepSeek 服务器

## 配置方法

### 1. 命令行参数

使用 `--provider` 参数指定提供商：

```bash
# 使用 Gemini (默认)
gemini --provider gemini --model gemini-1.5-flash --prompt "Hello"

# 使用 Deepseek
gemini --provider deepseek --model deepseek-chat --prompt "Hello"

# 使用本地 DeepSeek
gemini --provider local-deepseek --model deepseek-chat --prompt "Hello"
```

### 2. 环境变量

设置 `GEMINI_PROVIDER` 环境变量来指定默认提供商：

```bash
# 设置默认提供商为 Deepseek
export GEMINI_PROVIDER=deepseek

# 设置默认提供商为本地 DeepSeek
export GEMINI_PROVIDER=local-deepseek

# 然后可以直接使用，无需 --provider 参数
gemini --model deepseek-chat --prompt "Hello"
```

## API密钥配置

### Gemini API密钥
```bash
export GEMINI_API_KEY="your-gemini-api-key"
```

### Deepseek API密钥
```bash
export DEEPSEEK_API_KEY="your-deepseek-api-key"
```

### 本地 DeepSeek 配置
```bash
# 基本配置
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL="http://localhost:8000"
export DEEPSEEK_API_KEY="your-local-api-key"  # 可选
export DEEPSEEK_TIMEOUT="30000"  # 可选，默认30秒
```

## 使用示例

### 基本使用

```bash
# 使用 Gemini
gemini --provider gemini --model gemini-1.5-flash --prompt "解释量子计算"

# 使用 Deepseek
gemini --provider deepseek --model deepseek-chat --prompt "解释量子计算"

# 使用本地 DeepSeek
gemini --provider local-deepseek --model deepseek-chat --prompt "解释量子计算"
```

### 交互模式

```bash
# 启动交互模式，使用 Deepseek
gemini --provider deepseek --model deepseek-chat

# 启动交互模式，使用本地 DeepSeek
gemini --provider local-deepseek --model deepseek-chat
```

### 流式输出

所有提供商都支持流式输出，无需额外配置：

```bash
gemini --provider deepseek --model deepseek-chat --prompt "写一个故事"
gemini --provider local-deepseek --model deepseek-chat --prompt "写一个故事"
```

## 模型名称

### Gemini 模型
- `gemini-1.5-flash`
- `gemini-1.5-pro`
- `gemini-pro`

### Deepseek 模型
- `deepseek-chat`
- `deepseek-coder`

### 本地 DeepSeek 模型
- 取决于你的本地服务器支持的模型
- 常见模型：`deepseek-chat`, `deepseek-coder`, `your-custom-model`

## 故障排除

### 常见错误

1. **API密钥未设置**
   ```
   Error: DEEPSEEK_API_KEY environment variable is required for Deepseek provider
   ```
   解决方案：设置相应的API密钥环境变量

2. **API请求失败**
   ```
   Deepseek API error: 401 Unauthorized
   ```
   解决方案：检查API密钥是否正确

3. **本地服务器连接失败**
   ```
   Local Deepseek API error: 500 Internal Server Error
   ```
   解决方案：检查本地服务器是否正常运行

4. **超时错误**
   ```
   Local Deepseek API timeout after 30000ms
   ```
   解决方案：增加超时时间或检查网络连接

5. **模型不存在**
   ```
   Deepseek API error: 404 Not Found
   ```
   解决方案：检查模型名称是否正确

### 调试模式

启用调试模式获取更多信息：

```bash
gemini --provider deepseek --model deepseek-chat --prompt "test" --debug
gemini --provider local-deepseek --model deepseek-chat --prompt "test" --debug
```

## 高级配置

### 自定义API端点

对于自托管的Deepseek实例，可以通过环境变量配置：

```bash
# 远程 DeepSeek
export DEEPSEEK_BASE_URL="https://your-custom-endpoint.com"

# 本地 DeepSeek
export DEEPSEEK_BASE_URL="http://192.168.1.100:8000"
```

### 温度和其他参数

支持通过 `--temperature` 等参数调整生成参数：

```bash
gemini --provider deepseek --model deepseek-chat --prompt "creative story" --temperature 0.8
gemini --provider local-deepseek --model deepseek-chat --prompt "creative story" --temperature 0.8
```

## 本地 DeepSeek 特殊配置

### 1. 无认证模式

如果你的本地服务器不需要认证：

```bash
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL="http://localhost:8000"
# 不设置 DEEPSEEK_API_KEY
```

### 2. 自定义超时

```bash
export DEEPSEEK_TIMEOUT="60000"  # 60秒
```

### 3. 网络配置

```bash
# 使用内网地址
export DEEPSEEK_BASE_URL="http://10.0.0.100:8000"

# 使用 HTTPS
export DEEPSEEK_BASE_URL="https://your-server:8000"
```

## 扩展支持

要添加新的提供商支持，需要：

1. 创建新的适配器类实现 `ContentGenerator` 接口
2. 在 `contentGenerator.ts` 中添加提供商检测逻辑
3. 更新文档和类型定义

## 注意事项

- 不同提供商的API限制和计费方式可能不同
- 建议在生产环境中使用适当的错误处理和重试机制
- 某些高级功能（如工具调用）可能仅在特定提供商中可用
- 本地 DeepSeek 服务器需要支持 OpenAI 兼容的 API 格式