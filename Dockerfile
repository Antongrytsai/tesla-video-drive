FROM node:18-slim

# Устанавливаем ffmpeg, python3 и pip для работы yt-dlp
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    && rm -rf /var/list/apt/lists/*

# Устанавливаем yt-dlp через pip
RUN pip3 install --no-cache-dir --break-system-packages yt-dlp

WORKDIR /app

# Копируем файлы зависимостей и устанавливаем их
COPY package*.json ./
RUN npm install --production

# Копируем остальные файлы проекта
COPY . .

# Открываем порт, который использует приложение
EXPOSE 8742

# Запуск приложения
CMD ["npm", "start"]
