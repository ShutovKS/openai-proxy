# OpenAI 代理

[俄语](./README.md) | [英文](./README.en.md) | [中文](./README.zh.md) |

一个简单的自托管 OpenAI API 代理。  
只需把 `https://api.openai.com` 换成你自己的地址即可。

## 安装

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env    # 如有需要，调整 PORT/API_URL
npm install
````

## 启动

```bash
npm start
# 或者在带自动重启的开发模式下运行：
npm run dev
```

## 使用

* 在客户端将基础 URL 改为 `http://<your-host>:<PORT>/v1`
* 像平时一样传递头 `Authorization: Bearer <YOUR_OPENAI_KEY>`
* 其他所有端点和头部都与 OpenAI 官方保持一致

`curl` 示例：

```bash
curl https://127.0.0.1:4937/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_TOKEN" \
  -d '{
  "model": "gpt-4o",
  "messages": [
    {
      "role": "user",
      "content": "Write a one-sentence bedtime story about a unicorn."
    }
  ]
}'
```
