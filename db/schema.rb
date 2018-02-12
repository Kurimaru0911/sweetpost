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

ActiveRecord::Schema.define(version: 20180212093756) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "sweet_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sweet_id"], name: "index_comments_on_sweet_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "sweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sweet_id"], name: "index_favorites_on_sweet_id", using: :btree
    t.index ["user_id", "sweet_id"], name: "index_favorites_on_user_id_and_sweet_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id", using: :btree
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "sweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "prefecture_id"
    t.string   "image"
    t.string   "name"
    t.index ["prefecture_id"], name: "index_sweets_on_prefecture_id", using: :btree
    t.index ["user_id"], name: "index_sweets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "prefecture_id"
    t.index ["prefecture_id"], name: "index_users_on_prefecture_id", using: :btree
  end

  create_table "wents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "sweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sweet_id"], name: "index_wents_on_sweet_id", using: :btree
    t.index ["user_id", "sweet_id"], name: "index_wents_on_user_id_and_sweet_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_wents_on_user_id", using: :btree
  end

  add_foreign_key "comments", "sweets"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "sweets"
  add_foreign_key "favorites", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "sweets", "prefectures"
  add_foreign_key "sweets", "users"
  add_foreign_key "users", "prefectures"
  add_foreign_key "wents", "sweets"
  add_foreign_key "wents", "users"
end
