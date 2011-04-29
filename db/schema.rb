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

ActiveRecord::Schema.define(:version => 20111042972029) do

  create_table "boards", :force => true do |t|
    t.string   "name",          :default => "", :null => false
    t.integer  "displayorder",  :default => 0,  :null => false
    t.text     "introduction",                  :null => false
    t.text     "notice",                        :null => false
    t.string   "logo",          :default => "", :null => false
    t.string   "banner",        :default => "", :null => false
    t.integer  "readperm",      :default => 0,  :null => false
    t.integer  "topicperm",     :default => 0,  :null => false
    t.integer  "postperm",      :default => 0,  :null => false
    t.integer  "superboard_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "logo"
    t.string   "introduction"
    t.integer  "displayorder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moderations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "association_id"
    t.string   "association_type"
    t.string   "action"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigations", :force => true do |t|
    t.string  "name"
    t.string  "url"
    t.integer "displayorder"
    t.integer "usergroup_id"
    t.integer "super_id"
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "assocaion_id"
    t.string   "assocaion_type"
    t.integer  "from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "from_user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "nickname",    :default => "",    :null => false
    t.string   "password",                       :null => false
    t.string   "email",       :default => "",    :null => false
    t.integer  "role_id",     :default => 0,     :null => false
    t.boolean  "locked",      :default => false, :null => false
    t.string   "regip",       :default => "",    :null => false
    t.string   "lastloginip", :default => "",    :null => false
    t.integer  "viewnum",     :default => 0,     :null => false
    t.integer  "onlinetime",  :default => 0,     :null => false
    t.integer  "credit1",     :default => 0,     :null => false
    t.integer  "credit2",     :default => 0,     :null => false
    t.integer  "credit3",     :default => 0,     :null => false
    t.integer  "credit4",     :default => 0,     :null => false
    t.integer  "credit5",     :default => 0,     :null => false
    t.integer  "credit6",     :default => 0,     :null => false
    t.integer  "credit7",     :default => 0,     :null => false
    t.integer  "credit8",     :default => 0,     :null => false
    t.string   "locale"
    t.string   "theme"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
