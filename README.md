# OpenAI Proxy

[Russia](./README.md) | [English](./README.en.md) |[中文](./README.zh.md) |

Простой самохостящийся прокси для OpenAI API.  
Позволяет просто сменить `https://api.openai.com` на ваш собственный адрес.

## Установка

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env    # и подправьте PORT/API_URL, если нужно
npm install
````

## Запуск

```bash
npm start
# или в режиме разработки с авто-рестартом:
npm run dev
```

## Использование

* В клиенте меняете базовый URL на `http://<your-host>:<PORT>/v1`
* Передаёте заголовок `Authorization: Bearer <YOUR_OPENAI_KEY>` как обычно
* Все остальные эндпоинты и заголовки остаются такими же, как у OpenAI

Пример на `curl`:

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