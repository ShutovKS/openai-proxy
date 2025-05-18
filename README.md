# OpenAI Proxy

[На русском](./README.md) | [English](./README.en.md) | [中文](./README.zh.md)

Простой самохостящийся прокси для OpenAI API.  
Позволяет заменить `https://api.openai.com` на свой сервер и проксировать все запросы.

---

## ⚡ Быстрый старт

> Требуется: Linux, root-доступ, Node.js (если нет — установится автоматически)

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
sudo ./setup.sh
````

После запуска сервис будет доступен по адресу:

```
http://<ваш-ip>:<PORT>/v1
```

По умолчанию порт — `4937`, можно изменить в `.env`.

---

## 🧰 Что делает `setup.sh`

* Проверяет и при необходимости устанавливает Node.js и npm
* Копирует `.env.example` → `.env` (если нет)
* Устанавливает зависимости `npm install`
* Создаёт и запускает systemd-сервис `openai-proxy`
* Включает автозапуск сервиса при старте системы

---

## 🛠 Ручная установка (альтернатива)

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env   # настройте PORT и API_URL при необходимости
npm install
npm start
```

---

## 🚀 Режимы запуска

* **npm start** — обычный запуск
* **npm run dev** — с авто-перезапуском при изменениях (через `nodemon`)

---

## 📦 Использование

В клиенте:

1. Замените base URL с `https://api.openai.com` → `http://<your-host>:<PORT>/v1`
2. Используйте `Authorization: Bearer <ваш_ключ_OpenAI>` как обычно
3. Эндпоинты и заголовки полностью совпадают с оригинальными OpenAI API

Пример запроса через `curl`:

```bash
curl http://127.0.0.1:4937/v1/chat/completions \
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

---

## 🧯 Траблшутинг

**Проверка статуса systemd-сервиса:**

```bash
sudo systemctl status openai-proxy
```

**Логи сервиса:**

```bash
sudo journalctl -u openai-proxy -f
```

**Перезапуск:**

```bash
sudo systemctl restart openai-proxy
```

---

## 📁 Конфигурация

Файл `.env`:

```dotenv
PORT=4937
API_URL=https://api.openai.com
```