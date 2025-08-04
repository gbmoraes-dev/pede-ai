import { reset } from 'drizzle-seed'
import { db } from '@/db/client'
import * as schemas from '@/db/schemas/schemas'

export async function resetDatabase() {
  await reset(db, schemas)
}
