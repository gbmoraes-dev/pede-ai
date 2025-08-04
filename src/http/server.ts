import { treaty } from '@elysiajs/eden'
import { Elysia } from 'elysia'
import { env } from '@/env'
import { healthCheck } from './routes/health-check'

const app = new Elysia()
  .use(healthCheck)
  .listen({ hostname: env.HOST, port: env.PORT })

export const api = treaty(app)

console.log(`
  🦊 Elysia is running at http://${app.server?.hostname}:${app.server?.port}
  
  📚 API docs at http://${app.server?.hostname}:${app.server?.port}/docs

  🌿 Mode: ${env.NODE_ENV}
  `)
