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

ActiveRecord::Schema[7.0].define(version: 2022_05_01_012112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.text "name", null: false
    t.text "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.timestamptz "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.text "key", null: false
    t.text "filename", null: false
    t.text "content_type"
    t.text "metadata"
    t.text "service_name", null: false
    t.bigint "byte_size", null: false
    t.text "checksum"
    t.timestamptz "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.text "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "world_id"
    t.bigint "user_id", null: false
    t.text "first_name", null: false
    t.text "last_name"
    t.text "title"
    t.text "description"
    t.text "filename"
    t.timestamptz "created_at", precision: 6, null: false
    t.timestamptz "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
    t.index ["world_id"], name: "index_characters_on_world_id"
  end

  create_table "relationship_types", force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.text "color"
    t.timestamptz "created_at", precision: 6, null: false
    t.timestamptz "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "relationship_with_id", null: false
    t.bigint "relationship_type_id"
    t.bigint "world_id"
    t.bigint "user_id", null: false
    t.text "color"
    t.text "name"
    t.text "description"
    t.bigint "relationship_type_forward_id"
    t.text "name_forward"
    t.text "description_forward"
    t.bigint "relationship_type_backward_id"
    t.text "name_backward"
    t.text "description_backward"
    t.timestamptz "created_at", precision: 6, null: false
    t.timestamptz "updated_at", precision: 6, null: false
    t.index "(GREATEST(character_id, relationship_with_id)), (LEAST(character_id, relationship_with_id))", name: "index_relationships_unique", unique: true
    t.index ["character_id"], name: "index_relationships_on_character_id"
    t.index ["relationship_type_backward_id"], name: "index_relationships_on_relationship_type_backward_id"
    t.index ["relationship_type_forward_id"], name: "index_relationships_on_relationship_type_forward_id"
    t.index ["relationship_type_id"], name: "index_relationships_on_relationship_type_id"
    t.index ["relationship_with_id"], name: "index_relationships_on_relationship_with_id"
    t.index ["user_id"], name: "index_relationships_on_user_id"
    t.index ["world_id"], name: "index_relationships_on_world_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "username", default: "", null: false
    t.text "email", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.timestamptz "reset_password_sent_at"
    t.timestamptz "remember_created_at"
    t.text "display_name"
    t.timestamptz "created_at", precision: 6, null: false
    t.timestamptz "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "worlds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "name", null: false
    t.text "description"
    t.timestamptz "created_at", precision: 6, null: false
    t.timestamptz "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_worlds_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "characters", "users"
  add_foreign_key "characters", "worlds"
  add_foreign_key "relationships", "characters"
  add_foreign_key "relationships", "characters", column: "relationship_with_id"
  add_foreign_key "relationships", "relationship_types"
  add_foreign_key "relationships", "relationship_types", column: "relationship_type_backward_id"
  add_foreign_key "relationships", "relationship_types", column: "relationship_type_forward_id"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "worlds"
  add_foreign_key "worlds", "users"
end
