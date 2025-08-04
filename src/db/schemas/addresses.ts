import { createId } from '@paralleldrive/cuid2'
import {
  boolean,
  geometry,
  index,
  pgTable,
  text,
  timestamp,
} from 'drizzle-orm/pg-core'
import { customers } from './customers'

export const addresses = pgTable(
  'addresses',
  {
    id: text()
      .$defaultFn(() => createId())
      .primaryKey(),
    customerId: text()
      .references(() => customers.id, { onDelete: 'cascade' })
      .notNull(),
    street: text().notNull(),
    number: text().notNull(),
    complement: text(),
    neighborhood: text().notNull(),
    city: text().notNull(),
    state: text().notNull(),
    zipCode: text().notNull(),
    country: text().notNull(),
    location: geometry({ type: 'point', mode: 'tuple', srid: 4326 }).notNull(),
    isDefault: boolean().default(false).notNull(),
    createdAt: timestamp().defaultNow().notNull(),
    updatedAt: timestamp().defaultNow().notNull(),
  },
  (table) => [
    index().on(table.customerId),
    index().on(table.zipCode),
    index().on(table.city, table.state),
    index().using('gist', table.location),
  ],
)
