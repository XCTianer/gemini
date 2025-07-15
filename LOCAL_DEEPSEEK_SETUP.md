# 本地 DeepSeek 服务器配置指南

## 概述

本指南将帮助你配置 Gemini CLI 以使用本地部署的 DeepSeek 服务器。

## 支持的配置方式

### 方式一：使用环境变量（推荐）

#### 1. 基本配置

```bash
# 设置提供商为本地 DeepSeek
export GEMINI_PROVIDER=local-deepseek

# 设置本地服务器地址（可选，默认为 http://localhost:8000）
export DEEPSEEK_BASE_URL=http://localhost:8000

# 设置 API 密钥（如果本地服务器需要认证）
export DEEPSEEK_API_KEY=your_local_api_key

# 设置超时时间（可选，默认为 30000ms）
export DEEPSEEK_TIMEOUT=30000
```

#### 2. 使用示例

```bash
# 基本使用
./gemini-cli --model deepseek-chat --prompt "Hello"

# 指定模型
./gemini-cli --model your-local-model --prompt "Hello"

# 交互模式
./gemini-cli --model deepseek-chat

# 流式输出
./gemini-cli --model deepseek-chat --prompt "写一个故事"
```

### 方式二：使用命令行参数

```bash
# 直接指定提供商
./gemini-cli --provider local-deepseek --model deepseek-chat --prompt "Hello"

# 结合环境变量
export DEEPSEEK_BASE_URL=http://192.168.1.100:8000
./gemini-cli --provider local-deepseek --model deepseek-chat --prompt "Hello"
```

## 本地服务器要求

### API 端点

本地 DeepSeek 服务器需要提供以下 API 端点：

- **POST** `/v1/chat/completions` - 聊天完成接口
- **POST** `/v1/chat/completions` (stream=true) - 流式聊天接口

### 请求格式

服务器需要支持标准的 OpenAI 兼容格式：

```json
{
  "model": "deepseek-chat",
  "messages": [
    {"role": "user", "content": "Hello"}
  ],
  "stream": false,
  "temperature": 0.7,
  "max_tokens": 1000,
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "get_weather",
        "description": "Get weather information",
        "parameters": {
          "type": "object",
          "properties": {
            "location": {
              "type": "string",
              "description": "City name"
            }
          }
        }
      }
    }
  ]
}
```

### 响应格式

服务器需要返回标准的 OpenAI 兼容响应：

```json
{
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Hello! How can I help you today?"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 10,
    "completion_tokens": 20,
    "total_tokens": 30
  }
}
```

## 常见部署方案

### 1. Docker 部署

```bash
# 拉取 DeepSeek 镜像
docker pull deepseek/deepseek-chat

# 运行容器
docker run -d \
  --name deepseek-server \
  -p 8000:8000 \
  -e API_KEY=your_api_key \
  deepseek/deepseek-chat

# 配置 CLI
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL=http://localhost:8000
export DEEPSEEK_API_KEY=your_api_key
```

### 2. 本地 Python 部署

```bash
# 安装 DeepSeek
pip install deepseek

# 启动服务器
deepseek serve --host 0.0.0.0 --port 8000

# 配置 CLI
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL=http://localhost:8000
```

### 3. 自托管部署

```bash
# 克隆 DeepSeek 仓库
git clone https://github.com/deepseek-ai/DeepSeek.git
cd DeepSeek

# 安装依赖
pip install -r requirements.txt

# 启动服务器
python server.py --host 0.0.0.0 --port 8000

# 配置 CLI
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL=http://localhost:8000
```

## 故障排除

### 1. 连接错误

```bash
# 检查服务器是否运行
curl http://localhost:8000/v1/models

# 检查端口是否开放
netstat -tlnp | grep 8000

# 检查防火墙设置
sudo ufw status
```

### 2. 认证错误

```bash
# 检查 API 密钥是否正确
echo $DEEPSEEK_API_KEY

# 测试认证
curl -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
     http://localhost:8000/v1/models
```

### 3. 超时错误

```bash
# 增加超时时间
export DEEPSEEK_TIMEOUT=60000

# 检查网络延迟
ping localhost
```

### 4. 模型不存在

```bash
# 查看可用模型
curl http://localhost:8000/v1/models

# 使用正确的模型名称
./gemini-cli --model your-actual-model-name --prompt "Hello"
```

## 高级配置

### 1. 自定义模型映射

在 `packages/core/src/core/client.ts` 中添加模型映射：

```typescript
if (provider === 'local-deepseek' && model === DEFAULT_GEMINI_FLASH_MODEL) {
  modelToUse = 'your-local-model-name';
}
```

### 2. 负载均衡

```bash
# 使用多个服务器
export DEEPSEEK_BASE_URL=http://load-balancer:8000

# 或者使用环境变量轮换
export DEEPSEEK_BASE_URL=http://server1:8000
# 失败时切换到 server2
```

### 3. 监控和日志

```bash
# 启用调试模式
DEBUG=1 ./gemini-cli --provider local-deepseek --model deepseek-chat --prompt "test"

# 查看详细日志
./gemini-cli --provider local-deepseek --model deepseek-chat --prompt "test" --debug
```

## 性能优化

### 1. 网络优化

```bash
# 使用本地网络
export DEEPSEEK_BASE_URL=http://192.168.1.100:8000

# 使用 Unix socket（如果支持）
export DEEPSEEK_BASE_URL=unix:///tmp/deepseek.sock
```

### 2. 缓存配置

```bash
# 启用响应缓存
export GEMINI_CACHE_ENABLED=true
export GEMINI_CACHE_DIR=~/.gemini/cache
```

### 3. 并发控制

```bash
# 限制并发请求数
export GEMINI_MAX_CONCURRENT_REQUESTS=5
```

## 安全考虑

### 1. 网络安全

```bash
# 使用 HTTPS
export DEEPSEEK_BASE_URL=https://your-server:8000

# 使用 VPN 或内网
export DEEPSEEK_BASE_URL=http://10.0.0.100:8000
```

### 2. 认证安全

```bash
# 使用强密码
export DEEPSEEK_API_KEY=your_very_strong_api_key

# 定期轮换密钥
# 使用环境变量文件
source ~/.deepseek_env
```

### 3. 访问控制

```bash
# 限制 IP 访问
# 在服务器端配置防火墙规则
sudo ufw allow from 192.168.1.0/24 to any port 8000
```

## 示例配置文件

创建 `~/.deepseek_env` 文件：

```bash
#!/bin/bash
# DeepSeek 本地服务器配置

# 基本配置
export GEMINI_PROVIDER=local-deepseek
export DEEPSEEK_BASE_URL=http://localhost:8000
export DEEPSEEK_API_KEY=your_api_key_here
export DEEPSEEK_TIMEOUT=30000

# 可选配置
export GEMINI_MODEL=deepseek-chat
export DEBUG=0
```

使用配置文件：

```bash
# 加载配置
source ~/.deepseek_env

# 使用 CLI
./gemini-cli --prompt "Hello"
```

## 支持的功能

### ✅ 已支持

- 基本文本生成
- 流式输出
- 工具调用 (Function Calling)
- 自定义模型名称
- 超时配置
- 错误处理

### ❌ 不支持

- 嵌入功能 (Embedding)
- 图像处理
- 多模态输入

## 更新日志

- **v1.0.0**: 初始版本，支持基本的本地 DeepSeek 服务器
- **v1.1.0**: 添加了超时配置和更好的错误处理
- **v1.2.0**: 支持工具调用和流式输出 