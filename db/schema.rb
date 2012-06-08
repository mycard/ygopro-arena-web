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

ActiveRecord::Schema.define(:version => 20120531032103) do

  create_table "attachments", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "post_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

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

  create_table "decks", :force => true do |t|
    t.integer  "library_id"
    t.integer  "user_id"
    t.integer  "duel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "decks", ["duel_id"], :name => "index_decks_on_duel_id"
  add_index "decks", ["library_id"], :name => "index_decks_on_library_id"
  add_index "decks", ["user_id"], :name => "index_decks_on_user_id"

  create_table "duels", :force => true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "winner_id"
    t.integer  "winreason"
    t.string   "replay"
    t.integer  "user1_credits"
    t.integer  "user2_credits"
    t.integer  "version"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "user1_public",  :default => true, :null => false
    t.boolean  "user2_public",  :default => true, :null => false
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

  create_table "libraries", :force => true do |t|
    t.string   "name"
    t.text     "contents"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "libraries", ["parent_id"], :name => "index_libraries_on_parent_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "logo"
    t.string   "introduction"
    t.integer  "displayorder"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player1_score"
    t.integer  "player2_id"
    t.integer  "player2_score"
    t.integer  "round"
    t.integer  "duel1_id"
    t.integer  "duel2_id"
    t.integer  "duel3_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "matches", ["duel1_id"], :name => "index_matches_on_duel1_id"
  add_index "matches", ["duel2_id"], :name => "index_matches_on_duel2_id"
  add_index "matches", ["duel3_id"], :name => "index_matches_on_duel3_id"
  add_index "matches", ["player1_id"], :name => "index_matches_on_player1_id"
  add_index "matches", ["player2_id"], :name => "index_matches_on_player2_id"
  add_index "matches", ["tournament_id"], :name => "index_matches_on_tournament_id"

  create_table "moderations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "association_id"
    t.string   "association_type"
    t.string   "action"
    t.string   "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "moderators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "moderators", ["board_id"], :name => "index_moderators_on_board_id"
  add_index "moderators", ["user_id"], :name => "index_moderators_on_user_id"

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

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "ip"
    t.integer  "port"
    t.integer  "http_port"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "location_type"
    t.string   "location"
    t.text     "note"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                      :null => false
    t.string   "password"
    t.string   "email",                  :default => "",    :null => false
    t.string   "nickname",               :default => "",    :null => false
    t.text     "signature"
    t.integer  "credits",                :default => 0,     :null => false
    t.integer  "credit1",                :default => 0,     :null => false
    t.integer  "credit2",                :default => 0,     :null => false
    t.integer  "credit3",                :default => 0,     :null => false
    t.integer  "credit4",                :default => 0,     :null => false
    t.integer  "credit5",                :default => 0,     :null => false
    t.integer  "credit6",                :default => 0,     :null => false
    t.integer  "credit7",                :default => 0,     :null => false
    t.integer  "credit8",                :default => 0,     :null => false
    t.integer  "win",                    :default => 0,     :null => false
    t.integer  "lost",                   :default => 0,     :null => false
    t.integer  "role_id",                :default => 5,     :null => false
    t.boolean  "locked",                 :default => false, :null => false
    t.string   "regip",                  :default => "",    :null => false
    t.string   "lastloginip",            :default => "",    :null => false
    t.integer  "viewnum",                :default => 0,     :null => false
    t.integer  "onlinetime",             :default => 0,     :null => false
    t.string   "locale"
    t.string   "theme"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
