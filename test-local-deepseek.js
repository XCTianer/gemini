#!/usr/bin/env node

/**
 * 本地 DeepSeek 适配器测试脚本
 */

// 设置环境变量
process.env.GEMINI_PROVIDER = 'local-deepseek';
process.env.DEEPSEEK_BASE_URL = 'http://localhost:8000';
process.env.DEEPSEEK_TIMEOUT = '5000';

async function testLocalDeepseekAdapter() {
  console.log('🧪 开始测试本地 DeepSeek 适配器...\n');

  try {
    // 动态导入适配器
    const { LocalDeepseekAdapter } = await import('./packages/core/dist/src/core/localDeepseekAdapter.js');
    
    console.log('✅ 成功导入 LocalDeepseekAdapter');
    
    // 创建适配器实例
    const adapter = new LocalDeepseekAdapter('', 'http://localhost:8000', 5000);
    console.log('✅ 成功创建适配器实例');
    
    // 测试请求格式转换
    const testRequest = {
      contents: [
        {
          role: 'user',
          parts: [{ text: 'Hello, how are you?' }]
        }
      ],
      model: 'deepseek-chat',
      config: {
        temperature: 0.7,
        maxOutputTokens: 100
      }
    };
    
    console.log('📝 测试请求格式转换...');
    const messages = adapter.convertToDeepseekMessages(testRequest);
    console.log('✅ 消息转换成功:', messages.length, '条消息');
    
    // 测试工具转换
    const testTools = [{
      functionDeclarations: [{
        name: 'get_weather',
        description: 'Get weather information',
        parameters: {
          type: 'object',
          properties: {
            location: {
              type: 'string',
              description: 'City name'
            }
          }
        }
      }]
    }];
    
    console.log('🔧 测试工具转换...');
    const tools = adapter.convertToDeepseekTools(testTools);
    console.log('✅ 工具转换成功:', tools.length, '个工具');
    
    // 测试 API 调用（预期会失败，因为服务器未运行）
    console.log('🌐 测试 API 调用（预期失败）...');
    try {
      await adapter.generateContent(testRequest);
    } catch (error) {
      console.log('✅ 正确捕获 API 错误:', error.message);
    }
    
    console.log('\n🎉 所有测试完成！');
    
  } catch (error) {
    console.error('❌ 测试失败:', error.message);
    process.exit(1);
  }
}

// 运行测试
testLocalDeepseekAdapter(); 