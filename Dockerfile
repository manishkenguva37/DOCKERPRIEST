# Use Node 18 Alpine – small & fast
FROM node:18-alpine

WORKDIR /app

# Copy both folders from monorepo-style structure
COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

# ───────────────────────────────────────
# Build artiqui (shared lib / dependency?)
# ───────────────────────────────────────
WORKDIR /app/artiqui
RUN npm ci --frozen-lockfile
RUN npm run build

# ───────────────────────────────────────
# Build book_priest (the actual app to deploy)
# ───────────────────────────────────────
WORKDIR /app/book_priest
RUN npm ci --frozen-lockfile
RUN npm run build

# ───────────────────────────────────────
# Create .vercel/output at WORKSPACE ROOT (/app)
# so it appears at github.workspace/.vercel/output after volume mount
# ───────────────────────────────────────
RUN mkdir -p /app/.vercel/output
RUN cp -r dist/* /app/.vercel/output/ || echo "Warning: no dist/ folder found – check your build output path"

# Optional – if your build outputs somewhere else, adjust cp, e.g.:
# RUN cp -r .next/* /app/.vercel/output/   ← for Next.js
# or
# RUN cp -r build/* /app/.vercel/output/   ← for Create React App / Vite etc.