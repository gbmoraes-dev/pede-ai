CREATE TYPE "public"."cuisines" AS ENUM('japanese', 'italian', 'brazillian', 'french');--> statement-breakpoint
CREATE TYPE "public"."roles" AS ENUM('customer', 'manager');--> statement-breakpoint
CREATE TABLE "addresses" (
	"id" text PRIMARY KEY NOT NULL,
	"customer_id" text NOT NULL,
	"street" text NOT NULL,
	"number" text NOT NULL,
	"complement" text,
	"neighborhood" text NOT NULL,
	"city" text NOT NULL,
	"state" text NOT NULL,
	"zip_code" text NOT NULL,
	"country" text NOT NULL,
	"location" geometry(point) NOT NULL,
	"is_default" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "customers" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	CONSTRAINT "customers_userId_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "managers" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"restaurant_id" text NOT NULL,
	CONSTRAINT "managers_userId_unique" UNIQUE("user_id"),
	CONSTRAINT "managers_restaurantId_unique" UNIQUE("restaurant_id")
);
--> statement-breakpoint
CREATE TABLE "restaurants" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text NOT NULL,
	"cuisine" "cuisines" NOT NULL,
	"location" geometry(point) NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" text PRIMARY KEY NOT NULL,
	"role" "roles" DEFAULT 'customer' NOT NULL,
	"first_name" text NOT NULL,
	"last_name" text NOT NULL,
	"phone" text NOT NULL,
	"email" text NOT NULL,
	"password" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "users_phone_unique" UNIQUE("phone"),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customers" ADD CONSTRAINT "customers_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "managers" ADD CONSTRAINT "managers_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "managers" ADD CONSTRAINT "managers_restaurant_id_restaurants_id_fk" FOREIGN KEY ("restaurant_id") REFERENCES "public"."restaurants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "addresses_customer_id_index" ON "addresses" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "addresses_zip_code_index" ON "addresses" USING btree ("zip_code");--> statement-breakpoint
CREATE INDEX "addresses_city_state_index" ON "addresses" USING btree ("city","state");--> statement-breakpoint
CREATE INDEX "addresses_location_index" ON "addresses" USING gist ("location");--> statement-breakpoint
CREATE INDEX "managers_restaurant_id_index" ON "managers" USING btree ("restaurant_id");--> statement-breakpoint
CREATE INDEX "restaurants_name_index" ON "restaurants" USING btree ("name");--> statement-breakpoint
CREATE INDEX "restaurants_cuisine_index" ON "restaurants" USING btree ("cuisine");--> statement-breakpoint
CREATE INDEX "restaurants_location_index" ON "restaurants" USING gist ("location");--> statement-breakpoint
CREATE INDEX "users_role_index" ON "users" USING btree ("role");