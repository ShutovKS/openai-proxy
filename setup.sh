#!/bin/bash
set -euo pipefail

# 1. Проверка запуска от root
if [[ $EUID -ne 0 ]]; then
  echo "Ошибка: скрипт нужно запустить под root или через sudo." >&2
  exit 1
fi

# 2. Определяем директорию приложения (где лежит этот скрипт)
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 3. Проверяем npm, ставим nodejs+npm если нужно
if ! command -v npm &>/dev/null; then
  echo "npm не найден. Устанавливаю nodejs+npm..."
  apt-get update
  apt-get install -y nodejs npm
fi

# 4. Устанавливаем зависимости
cd "$APP_DIR"
if [[ ! -f .env ]]; then
  echo "Копирую .env.example → .env"
  cp .env.example .env
fi
echo "Устанавливаю npm-зависимости..."
npm install

# 5. Готовим systemd-юнит
SERVICE_NAME="openai-proxy"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
NPM_BIN="$(command -v npm)"

cat >"$SERVICE_FILE" <<EOF
[Unit]
Description=OpenAI Proxy
After=network.target

[Service]
Type=simple
User=${SUDO_USER:-root}
WorkingDirectory=${APP_DIR}
ExecStart=${NPM_BIN} start
Restart=always
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

# 6. Перезагружаем демона, включаем и стартуем сервис
echo "Reload systemd, enable & start service..."
systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
systemctl restart "$SERVICE_NAME"

echo "✅ Сервис ${SERVICE_NAME} запущен и включён в автозагрузку."
