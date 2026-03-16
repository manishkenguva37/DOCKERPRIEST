# Use lightweight Node image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy both projects into container
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
# Vercel expects files in .vercel/output
RUN mkdir -p .vercel/output \
    && cp -r dist/* .vercel/output/

# Set environment for production
ENV NODE_ENV=production

# Optional: for local testing
# EXPOSE 5173
# CMD ["npm", "run", "dev", "--", "--host"]