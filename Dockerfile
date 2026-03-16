# Use a stable Node version
FROM node:18-alpine

# Set base working directory
WORKDIR /app

# Copy both projects into the container
COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

# -------------------------------
# Build artiqui project
# -------------------------------
WORKDIR /app/artiqui
RUN npm ci
RUN npm run build

# -------------------------------
# Build book_priest project
# -------------------------------
WORKDIR /app/book_priest
RUN npm ci
RUN npm run build

# -------------------------------
# Prepare Vercel prebuilt output
# -------------------------------
RUN mkdir -p .vercel/output \
    && cp -r dist/* .vercel/output/

# Set production environment
ENV NODE_ENV=production

# Optional: for local dev
# EXPOSE 5173
# CMD ["npm","run","dev","--","--host"]