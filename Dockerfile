FROM node:18-alpine

WORKDIR /app

COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

WORKDIR /app/artiqui
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

WORKDIR /app/book_priest
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

# Debug
RUN ls -la dist/ || echo "No dist/ after build!"

# We'll copy this folder out later – no .vercel here