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

ActiveRecord::Schema.define(version: 2021_08_08_181147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.bigint "world_id"
    t.bigint "user_id", null: false
    t.text "first_name", null: false
    t.text "last_name"
    t.text "title"
    t.text "description"
    t.text "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
    t.index ["world_id"], name: "index_characters_on_world_id"
  end

  create_table "relationship_types", force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.text "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "display_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "worlds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_worlds_on_user_id"
  end

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
