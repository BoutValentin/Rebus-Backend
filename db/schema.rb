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

ActiveRecord::Schema[7.0].define(version: 2022_03_08_160338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "icon_phonetics", force: :cascade do |t|
    t.bigint "icon_id", null: false
    t.bigint "direct_phonetic_id"
    t.bigint "undirect_phonetic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["direct_phonetic_id"], name: "index_icon_phonetics_on_direct_phonetic_id"
    t.index ["icon_id", "direct_phonetic_id"], name: "index_icon_phonetics_on_icon_id_and_direct_phonetic_id", unique: true
    t.index ["icon_id", "undirect_phonetic_id"], name: "index_icon_phonetics_on_icon_id_and_undirect_phonetic_id", unique: true
    t.index ["icon_id"], name: "index_icon_phonetics_on_icon_id"
    t.index ["undirect_phonetic_id"], name: "index_icon_phonetics_on_undirect_phonetic_id"
  end

  create_table "icons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phonetics", force: :cascade do |t|
    t.string "phonetic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rebus_reponses", force: :cascade do |t|
    t.string "word"
    t.integer "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syllable_letters", force: :cascade do |t|
    t.string "syllable_letter"
    t.bigint "phonetic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phonetic_id"], name: "index_syllable_letters_on_phonetic_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "icon_phonetics", "icons"
  add_foreign_key "icon_phonetics", "phonetics", column: "direct_phonetic_id"
  add_foreign_key "icon_phonetics", "phonetics", column: "undirect_phonetic_id"
  add_foreign_key "syllable_letters", "phonetics"
end
