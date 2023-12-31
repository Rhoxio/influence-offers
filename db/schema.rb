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

ActiveRecord::Schema[7.1].define(version: 2023_12_18_105556) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "claimed_offers", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_claimed_offers_on_offer_id"
    t.index ["player_id", "offer_id"], name: "index_claimed_offers_on_player_id_and_offer_id", unique: true
    t.index ["player_id"], name: "index_claimed_offers_on_player_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_genders", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "gender_id"
    t.index ["gender_id", "offer_id"], name: "index_offer_genders_on_gender_id_and_offer_id", unique: true
    t.index ["gender_id"], name: "index_offer_genders_on_gender_id"
    t.index ["offer_id"], name: "index_offer_genders_on_offer_id"
  end

  create_table "offer_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_tags_on_offer_id"
    t.index ["tag_id", "offer_id"], name: "index_offer_tags_on_tag_id_and_offer_id", unique: true
    t.index ["tag_id"], name: "index_offer_tags_on_tag_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "target_age"
    t.integer "max_age"
    t.integer "min_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_age"], name: "index_offers_on_target_age"
  end

  create_table "players", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "gender"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
