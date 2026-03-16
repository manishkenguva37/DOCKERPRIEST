# Use Node 18 Alpine for small size
FROM node:18-alpine

WORKDIR /app

# Copy both projects
COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

# -------------------------------
# Build artiqui
# -------------------------------
WORKDIR /app/artiqui
RUN npm ci
RUN npm run build

# -------------------------------
# Build book_priest
# -------------------------------
WORKDIR /app/book_priest
RUN npm ci
RUN npm run build

# -------------------------------
# Copy output to .vercel/output for prebuilt deploy
# -------------------------------
RUN mkdir -p .vercel/output && cp -r dist/* .vercel/output/

# Optional: local dev
# EXPOSE 5173
# CMD ["npm","run","dev","--","--host"]