FROM node:19-alpine as builder

#install curl
#RUN apk --no-cache add curl

# install pnpm
#RUN curl -fsSL \
#    "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" \
#    -o /bin/pnpm; chmod +x /bin/pnpm
WORKDIR /app
RUN npm add -g pnpm

# install dependencies
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# copy source files and build
COPY . .
RUN pnpm build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
