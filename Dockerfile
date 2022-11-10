FROM node:19-alpine as builder

WORKDIR /app

# install pnpm
RUN npm add -g pnpm@latest

# install dependencies
COPY package.json pnpm-lock.yaml ./
#RUN pnpm install

# copy source files and build
#COPY . .
#RUN pnpm build

#FROM nginx:alpine

#COPY --from=builder /app/dist /usr/share/nginx/html
