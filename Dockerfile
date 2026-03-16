# Use Node 18 Alpine – small & fast
FROM node:18-alpine

WORKDIR /app

# Copy both projects
COPY artiqui /app/artiqui
COPY book_priest /app/book_priest

# Build artiqui first (assuming it's a dependency / shared lib)
WORKDIR /app/artiqui
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

# Build book_priest (the deployable app)
WORKDIR /app/book_priest
RUN npm ci --frozen-lockfile --prefer-offline
RUN npm run build

# Debug: show what was built
RUN ls -la dist/ || echo "dist/ folder missing or empty after build!"

# Create .vercel/output at WORKSPACE ROOT (/app)
# → lands at ${{ github.workspace }}/.vercel/output on host
RUN mkdir -p /app/.vercel/output

# Copy build output (Vite → dist/)
RUN cp -r dist/* /app/.vercel/output/ || { echo "ERROR: cp failed – dist/ missing!"; exit 1; }

# Final debug inside container
RUN ls -la /app/.vercel/output || echo "Output folder empty inside container"