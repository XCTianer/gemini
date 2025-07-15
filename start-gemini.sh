#!/bin/bash

# Gemini CLI 启动脚本
# 使用方法: ./start-gemini.sh

echo "🚀 启动 Gemini CLI..."

# 检查是否在正确的目录
if [ ! -f "gemini-cli" ]; then
    echo "❌ 错误: 请在项目根目录下运行此脚本"
    exit 1
fi

# 检查构建状态
echo "📦 检查构建状态..."
if ! npm run build > /dev/null 2>&1; then
    echo "❌ 构建失败，请检查错误信息"
    exit 1
fi

# 检查MCP配置
if [ ! -f ".gemini/settings.json" ]; then
    echo "⚠️  警告: 未找到 .gemini/settings.json 配置文件"
    echo "   请确保MCP服务器配置正确"
fi

# 设置环境变量
export GEMINI_PROVIDER=${GEMINI_PROVIDER:-deepseek}
export GEMINI_MODEL=${GEMINI_MODEL:-deepseek-chat}
export GEMINI_SANDBOX=${GEMINI_SANDBOX:-false}

echo "🔧 配置信息:"
echo "   - 提供商: $GEMINI_PROVIDER"
echo "   - 模型: $GEMINI_MODEL"
echo "   - 沙盒: $GEMINI_SANDBOX"

# 启动CLI
echo "🎯 启动 Gemini CLI..."
echo "   使用 Ctrl+C 退出"
echo "   使用 /mcp 查看MCP工具状态"
echo ""

./gemini-cli --provider "$GEMINI_PROVIDER" --model "$GEMINI_MODEL" "$@" 