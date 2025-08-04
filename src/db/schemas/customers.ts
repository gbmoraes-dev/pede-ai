import { createId } from '@paralleldrive/cuid2'
import { pgTable, text } from 'drizzle-orm/pg-core'
import { users } from './users'

export const customers = pgTable('customers', {
  id: text()
    .$defaultFn(() => createId())
    .primaryKey(),
  userId: text()
    .references(() => users.id, { onDelete: 'cascade' })
    .unique()
    .notNull(),
})
