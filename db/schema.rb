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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120409100915) do

  create_table "boards", :force => true do |t|
    t.string  "name",          :default => "", :null => false
    t.integer "superboard_id",                 :null => false
    t.integer "displayorder",  :default => 0,  :null => false
    t.text    "introduction",                  :null => false
    t.text    "notice",                        :null => false
    t.string  "logo",          :default => "", :null => false
    t.string  "banner",        :default => "", :null => false
    t.integer "readperm",      :default => 0,  :null => false
    t.integer "topicperm",     :default => 0,  :null => false
    t.integer "postperm",      :default => 0,  :null => false
  end

  create_table "cards", :force => true do |t|
    t.integer "number"
    t.string  "name"
    t.string  "card_type"
    t.string  "monster_type"
    t.integer "monster_atk"
    t.integer "monster_def"
    t.string  "monster_attribute"
    t.string  "type"
    t.integer "monster_level"
    t.text    "lore"
    t.integer "status"
    t.string  "stats"
    t.string  "archetypes"
    t.string  "mediums"
    t.integer "tokens"
  end

  add_index "cards", ["card_type"], :name => "index_cards_on_card_type"
  add_index "cards", ["name"], :name => "index_cards_on_name"
  add_index "cards", ["number"], :name => "index_cards_on_number"

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "duels", :force => true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "winner_id"
    t.integer  "winreason"
    t.string   "replay"
    t.integer  "user1_credits"
    t.integer  "user2_credits"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "duels", ["user1_id"], :name => "index_duels_on_user1_id"
  add_index "duels", ["user2_id"], :name => "index_duels_on_user2_id"

  create_table "duels_users_cards", :force => true do |t|
    t.integer "duel_id"
    t.integer "user_id"
    t.integer "card_id"
    t.boolean "main"
  end

  add_index "duels_users_cards", ["card_id"], :name => "index_duels_users_cards_on_card_id"
  add_index "duels_users_cards", ["duel_id"], :name => "index_duels_users_cards_on_duel_id"
  add_index "duels_users_cards", ["user_id"], :name => "index_duels_users_cards_on_user_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "logo"
    t.string   "introduction"
    t.integer  "displayorder"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "moderations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "association_id"
    t.string   "association_type"
    t.string   "action"
    t.string   "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "navigations", :force => true do |t|
    t.string  "name"
    t.string  "url"
    t.integer "displayorder"
    t.integer "role_id"
    t.integer "super_id"
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "assocaion_id"
    t.string   "assocaion_type"
    t.integer  "from_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "pms", :force => true do |t|
    t.integer  "from_user_id",                    :null => false
    t.integer  "to_user_id",                      :null => false
    t.boolean  "read",         :default => false, :null => false
    t.text     "content",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "displayorder"
    t.integer  "readperm"
    t.boolean  "private"
    t.boolean  "anonymous"
    t.boolean  "ubb"
    t.boolean  "html"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "roles", :force => true do |t|
    t.string  "name",                                  :null => false
    t.boolean "topic_delete",       :default => false, :null => false
    t.integer "topic_digest",       :default => 0,     :null => false
    t.integer "topic_displayorder", :default => 0,     :null => false
    t.boolean "topic_highlight",    :default => false, :null => false
    t.boolean "topic_edit",         :default => false, :null => false
    t.boolean "topic_lock",         :default => false, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :primary_key => "name", :force => true do |t|
    t.text "value"
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "type_id"
    t.integer  "category_id",                      :null => false
    t.string   "category_type",                    :null => false
    t.string   "name",                             :null => false
    t.boolean  "digest",        :default => false, :null => false
    t.integer  "displayorder",  :default => 0,     :null => false
    t.integer  "highlight",     :default => 0,     :null => false
    t.integer  "viewnum",       :default => 0,     :null => false
    t.integer  "readperm",      :default => 1,     :null => false
    t.boolean  "locked",        :default => false, :null => false
    t.boolean  "deleted",       :default => false, :null => false
    t.boolean  "reverse",       :default => false, :null => false
    t.boolean  "private",       :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "password"
    t.string   "email"
    t.string   "nickname",            :default => "",    :null => false
    t.text     "signature"
    t.integer  "credits",             :default => 0,     :null => false
    t.integer  "credit1",             :default => 0,     :null => false
    t.integer  "credit2",             :default => 0,     :null => false
    t.integer  "credit3",             :default => 0,     :null => false
    t.integer  "credit4",             :default => 0,     :null => false
    t.integer  "credit5",             :default => 0,     :null => false
    t.integer  "credit6",             :default => 0,     :null => false
    t.integer  "credit7",             :default => 0,     :null => false
    t.integer  "credit8",             :default => 0,     :null => false
    t.integer  "win",                 :default => 0,     :null => false
    t.integer  "lost",                :default => 0,     :null => false
    t.integer  "role_id",             :default => 5,     :null => false
    t.boolean  "locked",              :default => false, :null => false
    t.string   "regip",               :default => "",    :null => false
    t.string   "lastloginip",         :default => "",    :null => false
    t.integer  "viewnum",             :default => 0,     :null => false
    t.integer  "onlinetime",          :default => 0,     :null => false
    t.string   "locale"
    t.string   "theme"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
