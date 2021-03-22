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

ActiveRecord::Schema.define(version: 2021_03_22_104521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_tags", force: :cascade do |t|
    t.integer "ad_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ad_id", "tag_id"], name: "index_ad_tags_on_ad_id_and_tag_id", unique: true
    t.index ["ad_id"], name: "index_ad_tags_on_ad_id"
    t.index ["tag_id"], name: "index_ad_tags_on_tag_id"
  end

  create_table "ads", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id", null: false
    t.boolean "archived", default: false
    t.index ["category_id"], name: "index_ads_on_category_id"
    t.index ["user_id", "created_at"], name: "index_ads_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stub"
  end

  create_table "chats", force: :cascade do |t|
    t.string "subject_type"
    t.bigint "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_type", "subject_id"], name: "index_chats_on_subject_type_and_subject_id"
  end

  create_table "chats_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.index ["chat_id", "user_id"], name: "index_chats_users_on_chat_id_and_user_id"
    t.index ["user_id", "chat_id"], name: "index_chats_users_on_user_id_and_chat_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "text"
    t.integer "from_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "read", default: false
    t.bigint "chat_id", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["from_id"], name: "index_messages_on_from_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.text "description"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "ads", "categories"
  add_foreign_key "ads", "users"
  add_foreign_key "messages", "chats"
end
