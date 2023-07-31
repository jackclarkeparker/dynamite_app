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

ActiveRecord::Schema[7.0].define(version: 2023_07_31_051530) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer "entity_id"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "preferred_name"
    t.string "email_address"
    t.string "phone_number"
    t.string "bank_account"
    t.string "csc_number"
    t.datetime "valid_until", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id", null: false
    t.index ["region_id"], name: "index_contacts_on_region_id"
  end

  create_table "lesson_members", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "student_id"
    t.datetime "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_members_on_lesson_id"
    t.index ["student_id"], name: "index_lesson_members_on_student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "tutor_id", null: false
    t.integer "venue_id", null: false
    t.integer "week_day_index"
    t.time "start_time"
    t.integer "capacity"
    t.decimal "standard_price", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "availability"
    t.integer "duration"
    t.time "end_time"
    t.index ["tutor_id"], name: "index_lessons_on_tutor_id"
    t.index ["venue_id"], name: "index_lessons_on_venue_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_contacts", force: :cascade do |t|
    t.bigint "students_id", null: false
    t.bigint "contacts_id", null: false
    t.string "relation"
    t.boolean "primary_contact"
    t.boolean "account_holder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contacts_id"], name: "index_student_contacts_on_contacts_id"
    t.index ["students_id"], name: "index_student_contacts_on_students_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "preferred_name"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.integer "year_group"
    t.string "gender"
    t.bigint "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "keyboard"
    t.integer "age"
    t.index ["region_id"], name: "index_students_on_region_id"
  end

  create_table "tutors", force: :cascade do |t|
    t.string "preferred_name"
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "phone_number"
    t.string "delivery_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.integer "entity_id"
    t.datetime "valid_until", precision: nil
    t.bigint "region_id", null: false
    t.index ["region_id"], name: "index_tutors_on_region_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "standard_price", precision: 4, scale: 2
    t.bigint "region_id", null: false
    t.index ["region_id"], name: "index_venues_on_region_id"
  end

  add_foreign_key "contacts", "regions"
  add_foreign_key "lesson_members", "lessons"
  add_foreign_key "lesson_members", "students"
  add_foreign_key "lessons", "tutors"
  add_foreign_key "lessons", "venues"
  add_foreign_key "student_contacts", "contacts", column: "contacts_id"
  add_foreign_key "student_contacts", "students", column: "students_id"
  add_foreign_key "students", "regions"
  add_foreign_key "tutors", "regions"
  add_foreign_key "venues", "regions"
end
