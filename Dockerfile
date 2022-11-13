FROM node:19-alpine as builder

WORKDIR /app

# Install pnpm
RUN wget -qO- https://get.pnpm.io/install.sh | sh -

# Fetch packages from a lockfile into virtual store
COPY pnpm-lock.yaml .
RUN pnpm fetch

# Install all dependencies from virtual store and build
COPY . .
RUN pnpm install -r --offline
RUN pnpm build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
