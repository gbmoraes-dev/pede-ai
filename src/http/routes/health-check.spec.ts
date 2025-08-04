import { beforeEach, describe, expect, it } from 'bun:test'
import { resetDatabase } from '@/test/setup'
import { api } from '../server'

describe('Health check route', () => {
  beforeEach(async () => {
    await resetDatabase()
  })

  it('should be able to return 200 OK', async () => {
    const { status, data } = await api.healthz.get()

    expect(status).toBe(200)
    expect(data).toBe('OK')
  })
})
