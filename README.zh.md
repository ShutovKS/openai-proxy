# OpenAI 代理

[俄语](./README.md) | [英文](./README.en.md) | [中文](./README.zh.md)

一个简单的自托管 OpenAI API 代理。  
允许你将 `https://api.openai.com` 替换为你自己的服务器地址。

---

## ⚡ 快速启动

> 依赖要求：Linux，root 权限，如果没有 Node.js 将自动安装

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
chmod +x setup.sh
sudo ./setup.sh
````

启动后服务将可通过以下地址访问：

```
http://<你的IP>:<PORT>/v1
```

默认端口为 `4937`，可在 `.env` 中修改。

---

## 🧰 `setup.sh` 做了什么

* 如果没有安装 Node.js 和 npm，会自动安装
* 复制 `.env.example` → `.env`（如果不存在）
* 执行 `npm install` 安装依赖
* 创建并启动 systemd 服务 `openai-proxy`
* 设置服务开机自启

---

## 🛠 手动安装（可选方式）

```bash
git clone https://github.com/ShutovKS/openai-proxy.git
cd openai-proxy
cp .env.example .env   # 如有需要，修改 PORT 和 API_URL
npm install
npm start
```

---

## 🚀 启动模式

* **`npm start`** — 正常启动
* **`npm run dev`** — 开发模式（自动重启）

---

## 📦 使用说明

在客户端：

1. 将 base URL 从 `https://api.openai.com` 改为 `http://<你的地址>:<端口>/v1`
2. 使用正常的 `Authorization: Bearer <你的OpenAI密钥>` 头部
3. 所有其他 API 和头部保持不变

`curl` 示例：

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

## 🧯 故障排查

**检查 systemd 服务状态：**

```bash
sudo systemctl status openai-proxy
```

**查看服务日志：**

```bash
sudo journalctl -u openai-proxy -f
```

**重启服务：**

```bash
sudo systemctl restart openai-proxy
```

---

## 📁 配置文件

`.env` 文件内容：

```dotenv
PORT=4937
API_URL=https://api.openai.com
```
