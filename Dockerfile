FROM node:18-alpine

WORKDIR /app

COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

# Build artiqui (shared UI lib)
WORKDIR /app/artiqui
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

# Build book_priest app
WORKDIR /app/book_priest
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

# Verify build output exists
RUN ls -la dist/ || (echo "No dist/ after build!" && exit 1)

# Image is used only for artifact extraction in CI – no server needed
CMD ["echo", "Build artifacts ready"]