# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140416233335) do

  create_table "properties", force: true do |t|
    t.string "name"
    t.string "postfix"
  end

  create_table "property_values", force: true do |t|
    t.string  "value"
    t.integer "property_id"
    t.integer "torrent_id"
  end

  add_index "property_values", ["property_id"], name: "index_property_values_on_property_id"
  add_index "property_values", ["torrent_id"], name: "index_property_values_on_torrent_id"

  create_table "tag_properties", force: true do |t|
    t.integer "tag_id"
    t.integer "property_id"
  end

  add_index "tag_properties", ["property_id"], name: "index_tag_properties_on_property_id"
  add_index "tag_properties", ["tag_id"], name: "index_tag_properties_on_tag_id"

  create_table "taggings", force: true do |t|
    t.integer "torrent_id"
    t.integer "tag_id"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["torrent_id"], name: "index_taggings_on_torrent_id"

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "torrents", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_uid"
    t.string   "file_name"
  end

  create_table "trigrams", force: true do |t|
    t.string  "trigram",     limit: 3
    t.integer "score",       limit: 2
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "fuzzy_field"
  end

  add_index "trigrams", ["owner_id", "owner_type", "fuzzy_field", "trigram", "score"], name: "index_for_match"
  add_index "trigrams", ["owner_id", "owner_type"], name: "index_by_owner"

end
