import { createId } from '@paralleldrive/cuid2'
import {
  geometry,
  index,
  pgEnum,
  pgTable,
  text,
  timestamp,
} from 'drizzle-orm/pg-core'

export const cuisines = pgEnum('cuisines', [
  'japanese',
  'italian',
  'brazillian',
  'french',
])

export const restaurants = pgTable(
  'restaurants',
  {
    id: text()
      .$defaultFn(() => createId())
      .primaryKey(),
    name: text().notNull(),
    description: text().notNull(),
    cuisine: cuisines().notNull(),
    location: geometry({ type: 'point', mode: 'tuple', srid: 4326 }).notNull(),
    createdAt: timestamp().defaultNow().notNull(),
    updatedAt: timestamp().defaultNow().notNull(),
  },
  (table) => [
    index().on(table.name),
    index().on(table.cuisine),
    index().using('gist', table.location),
  ],
)
