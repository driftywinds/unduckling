# Stage 1 — builder
FROM node:18-bullseye-slim AS builder
WORKDIR /app

# copy lockfile and package manifest first for better caching
COPY package.json pnpm-lock.yaml* ./

# Use corepack to enable pnpm (Node 18+ includes corepack)
RUN corepack enable && corepack prepare pnpm@latest --activate

# install deps
RUN pnpm install --frozen-lockfile

# copy source and build
COPY . .
# build (script name in many Vite projects is "build")
RUN pnpm build

# Stage 2 — nginx static server
FROM nginx:alpine
# remove default nginx html
RUN rm -rf /usr/share/nginx/html/*
# copy built files from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# optional: copy a custom nginx conf to tweak headers, caching, single-page apps, etc.
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
STOPSIGNAL SIGTERM

# run nginx in foreground (default)
CMD ["nginx", "-g", "daemon off;"]
