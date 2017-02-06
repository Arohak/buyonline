# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160905115536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "distance"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.index ["category_id"], name: "index_category_translations_on_category_id", using: :btree
    t.index ["locale"], name: "index_category_translations_on_locale", using: :btree
  end

  create_table "categoryitem_translations", force: :cascade do |t|
    t.integer  "categoryitem_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.index ["categoryitem_id"], name: "index_categoryitem_translations_on_categoryitem_id", using: :btree
    t.index ["locale"], name: "index_categoryitem_translations_on_locale", using: :btree
  end

  create_table "categoryitems", force: :cascade do |t|
    t.integer  "categoryitem_id"
    t.integer  "rest_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "alias"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivery_translations", force: :cascade do |t|
    t.integer  "delivery_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "city"
    t.index ["delivery_id"], name: "index_delivery_translations_on_delivery_id", using: :btree
    t.index ["locale"], name: "index_delivery_translations_on_locale", using: :btree
  end

  create_table "deliveryaddresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "country"
    t.string   "city"
    t.string   "alias"
    t.string   "address"
    t.boolean  "def"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.boolean  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_favorites_on_product_id", using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "historyproducts", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "count_buy"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "date_create"
    t.string   "mobile_number"
    t.string   "delivery_address"
    t.string   "delivery_city"
    t.string   "delivery_alias"
    t.string   "delivery_date"
    t.string   "payment"
    t.decimal  "orders_total_price"
    t.decimal  "delivery_price"
    t.decimal  "total_price"
    t.boolean  "is_verified"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "product_translations", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "label"
    t.string   "content"
    t.index ["locale"], name: "index_product_translations_on_locale", using: :btree
    t.index ["product_id"], name: "index_product_translations_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "rest_id"
    t.integer  "categoryitem_id"
    t.integer  "menu"
    t.integer  "restaurant_menu_categories"
    t.boolean  "new"
    t.integer  "item_number"
    t.integer  "inventory"
    t.integer  "instock"
    t.integer  "desired_stock"
    t.string   "price"
    t.string   "type_"
    t.string   "alias"
    t.string   "keywords"
    t.string   "src"
    t.boolean  "favorite"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "restaurant_translations", force: :cascade do |t|
    t.integer  "restaurant_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "label"
    t.string   "description"
    t.index ["locale"], name: "index_restaurant_translations_on_locale", using: :btree
    t.index ["restaurant_id"], name: "index_restaurant_translations_on_restaurant_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.text     "hash_"
    t.string   "status"
    t.integer  "position"
    t.string   "budget"
    t.string   "openTime"
    t.string   "closeTime"
    t.string   "src"
    t.integer  "min_amount_order"
    t.integer  "rate"
    t.integer  "totalHours"
    t.integer  "around"
    t.boolean  "new"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "restaurants_subcategories", id: false, force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "subcategory_id"
  end

  create_table "shops", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "category_id"
    t.integer  "rate"
    t.string   "budget"
    t.boolean  "new"
    t.integer  "min_amount_order"
    t.text     "hash_"
    t.integer  "position"
    t.text     "description"
    t.string   "label"
    t.integer  "totalHours"
    t.string   "openTime"
    t.string   "closeTime"
    t.integer  "around"
    t.string   "status"
    t.string   "src"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "position"
    t.string   "src"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "subcategory_translations", force: :cascade do |t|
    t.integer  "subcategory_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.string   "title"
    t.index ["locale"], name: "index_subcategory_translations_on_locale", using: :btree
    t.index ["subcategory_id"], name: "index_subcategory_translations_on_subcategory_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "email"
    t.string   "mobile_number"
    t.string   "verification_code"
    t.boolean  "is_verified"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "users"
end
