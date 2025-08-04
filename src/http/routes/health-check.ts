import { Elysia, t } from 'elysia'

export const healthCheck = new Elysia().get(
  '/healthz',
  ({ status }) => {
    return status(200, 'OK')
  },
  {
    response: {
      200: t.Literal('OK'),
    },
  },
)
