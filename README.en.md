# OpenAI Proxy

[Russian](./README.md) | [English](./README.en.md) | [中文](./README.zh.md)

A simple self-hosted proxy for the OpenAI API.  
Allows you to replace `https://api.openai.com` with your own server.

---

## ⚡ Quick Start

> Requirements: Linux, root access, Node.js (will be installed automatically if missing)

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
sudo ./setup.sh
````

After launch, the service will be available at:

```
http://<your-ip>:<PORT>/v1
```

Default port is `4937`, configurable via `.env`.

---

## 🧰 What `setup.sh` Does

* Installs Node.js and npm if not already installed
* Copies `.env.example` → `.env` (if missing)
* Runs `npm install` to fetch dependencies
* Creates and starts a `systemd` service (`openai-proxy`)
* Enables auto-start on system boot

---

## 🛠 Manual Installation (alternative)

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env   # adjust PORT and API_URL as needed
npm install
npm start
```

---

## 🚀 Run Modes

* **`npm start`** — standard start
* **`npm run dev`** — with auto-restart (via `nodemon`)

---

## 📦 Usage

In your client:

1. Change base URL from `https://api.openai.com` → `http://<your-host>:<PORT>/v1`
2. Use `Authorization: Bearer <your_openai_key>` as usual
3. All endpoints and headers remain the same as OpenAI’s

Example using `curl`:

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

## 🧯 Troubleshooting

**Check systemd service status:**

```bash
sudo systemctl status openai-proxy
```

**View service logs:**

```bash
sudo journalctl -u openai-proxy -f
```

**Restart service:**

```bash
sudo systemctl restart openai-proxy
```

---

## 📁 Configuration

`.env` file:

```dotenv
PORT=4937
API_URL=https://api.openai.com
```