FROM oven/bun:1-debian AS base

# ---------

FROM base AS deps

WORKDIR /app

COPY package.json bun.lock ./

RUN bun install --production --frozen-lockfile

# ---------

FROM base AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

COPY ./src ./src

COPY ./tsconfig.json ./

ENV NODE_ENV=production

RUN bun build \
  --compile \
  --external pg \
  --minify-whitespace \
  --minify-syntax \
  --target bun \
  --outfile server \
  ./src/http/server.ts

# ---------

FROM gcr.io/distroless/base:nonroot AS runner

WORKDIR /app

COPY --from=builder /app/server server

ENV NODE_ENV=production

EXPOSE 3000

CMD ["./server"]
