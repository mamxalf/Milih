# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_12_230132) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "polling_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "polling_id", null: false
    t.string "description"
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["polling_id"], name: "index_polling_answers_on_polling_id"
  end

  create_table "pollings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "title"
    t.datetime "duration", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", default: -> { "md5((random())::text)" }, null: false
    t.index ["user_id"], name: "index_pollings_on_user_id"
  end

  create_table "qna_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "qna_room_id", null: false
    t.uuid "user_id"
    t.text "question"
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qna_room_id"], name: "index_qna_questions_on_qna_room_id"
    t.index ["user_id"], name: "index_qna_questions_on_user_id"
  end

  create_table "qna_rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "code", default: -> { "md5((random())::text)" }, null: false
    t.string "string", default: -> { "md5((random())::text)" }, null: false
    t.string "title"
    t.text "description"
    t.datetime "duration", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_qna_rooms_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "polling_answers", "pollings"
  add_foreign_key "pollings", "users"
  add_foreign_key "qna_questions", "qna_rooms"
  add_foreign_key "qna_questions", "users"
  add_foreign_key "qna_rooms", "users"
end
