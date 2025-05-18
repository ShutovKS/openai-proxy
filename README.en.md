# OpenAI Proxy

[Russian](./README.md) | [English](./README.en.md) | [中文](./README.zh.md) |

A simple self-hosted proxy for the OpenAI API.  
Just replace `https://api.openai.com` with your own address.

## Installation

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env    # and tweak PORT/API_URL if needed
npm install
````

## Running

```bash
npm start
# or in development mode with auto-restart:
npm run dev
```

## Usage

* In your client, change the base URL to `http://<your-host>:<PORT>/v1`
* Send the header `Authorization: Bearer <YOUR_OPENAI_KEY>` as usual
* All other endpoints and headers remain the same as OpenAI’s

Example with `curl`:

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
