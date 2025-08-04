import { createId } from '@paralleldrive/cuid2'
import { index, pgEnum, pgTable, text, timestamp } from 'drizzle-orm/pg-core'

export const roles = pgEnum('roles', ['customer', 'manager'])

export const users = pgTable(
  'users',
  {
    id: text()
      .$defaultFn(() => createId())
      .primaryKey(),
    role: roles().default('customer').notNull(),
    firstName: text().notNull(),
    lastName: text().notNull(),
    phone: text().unique().notNull(),
    email: text().unique().notNull(),
    password: text().notNull(),
    createdAt: timestamp().defaultNow().notNull(),
    updatedAt: timestamp().defaultNow().notNull(),
  },
  (table) => [index().on(table.role)],
)
