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

ActiveRecord::Schema.define(version: 20180908192933) do

  create_table "complications", force: :cascade do |t|
    t.string   "complication_name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "complication_description"
    t.index ["complication_name"], name: "index_complications_on_complication_name", unique: true
  end

  create_table "complications_watches", id: false, force: :cascade do |t|
    t.integer "watch_id",                 null: false
    t.integer "complication_id",          null: false
    t.string  "complication_description"
    t.index ["watch_id", "complication_id"], name: "index_complications_watches_on_watch_id_and_complication_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "name"
    t.string   "uid"
    t.string   "image"
    t.integer  "current_watch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watches", force: :cascade do |t|
    t.string   "watch_name"
    t.string   "watch_maker"
    t.string   "movement"
    t.string   "band"
    t.string   "model_number"
    t.string   "water_resistance"
    t.string   "date_bought"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "watch_image_file_name"
    t.string   "watch_image_content_type"
    t.integer  "watch_image_file_size",    limit: 8
    t.datetime "watch_image_updated_at"
    t.string   "cost"
    t.string   "case_measurement"
  end

end
