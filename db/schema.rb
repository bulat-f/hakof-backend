# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_18_053015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.string "cover"
    t.string "description"
    t.text "body"
    t.string "lang", null: false
    t.integer "author_id", null: false
    t.string "link"
    t.datetime "published_at"
    t.boolean "selected", default: false, null: false
    t.boolean "featured", default: false, null: false
    t.integer "views_count", default: 0, null: false
    t.integer "views_till_end_count", default: 0, null: false
    t.integer "sum_view_time_sec", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.string "tags", default: [], null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["featured"], name: "index_articles_on_featured"
    t.index ["lang"], name: "index_articles_on_lang"
    t.index ["selected"], name: "index_articles_on_selected"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "role", default: 0, null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
