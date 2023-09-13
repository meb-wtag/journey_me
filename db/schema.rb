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

ActiveRecord::Schema[7.0].define(version: 2023_09_04_121544) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journal_entries", force: :cascade do |t|
    t.integer "journal_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.text "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_journal_entries_on_journal_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 2
    t.string "password_digest"
    t.string "password_confirmation"
    t.text "description"
    t.string "email"
    t.integer "mobile"
    t.string "adress"
    t.string "country"
    t.string "city"
    t.date "date_of_birth"
    t.date "joining_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
