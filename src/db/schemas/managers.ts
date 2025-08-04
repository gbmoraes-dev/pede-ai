import { createId } from '@paralleldrive/cuid2'
import { index, pgTable, text } from 'drizzle-orm/pg-core'
import { restaurants } from './restaurants'
import { users } from './users'

export const managers = pgTable(
  'managers',
  {
    id: text()
      .$defaultFn(() => createId())
      .primaryKey(),
    userId: text()
      .references(() => users.id, { onDelete: 'cascade' })
      .unique()
      .notNull(),
    restaurantId: text()
      .references(() => restaurants.id, { onDelete: 'cascade' })
      .unique()
      .notNull(),
  },
  (table) => [index().on(table.restaurantId)],
)
