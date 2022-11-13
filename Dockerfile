FROM node:19-alpine as builder

WORKDIR /app

# Install curl
RUN apk --no-cache add curl

# Install pnpm
RUN curl -fsSL \
    "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" \
    -o /bin/pnpm; chmod +x /bin/pnpm;

# Fetch packages from a lockfile into virtual store
COPY pnpm-lock.yaml .
RUN pnpm fetch

# Install all dependencies from virtual store and build
COPY . .
RUN pnpm install -r --offline
RUN pnpm build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
