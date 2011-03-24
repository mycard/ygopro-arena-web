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

ActiveRecord::Schema.define(:version => 20101226125042) do

  create_table "boards", :force => true do |t|
    t.string   "name"
    t.text     "introduction"
    t.text     "notice"
    t.string   "logo"
    t.string   "banner"
    t.integer  "readperm"
    t.integer  "topicperm"
    t.integer  "postperm"
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

  create_table "moderations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "association_id"
    t.string   "association_type"
    t.string   "action"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "type_id"
    t.integer  "category_id"
    t.string   "category_type"
    t.string   "name"
    t.integer  "displayorder"
    t.integer  "views"
    t.integer  "readperm"
    t.boolean  "locked"
    t.boolean  "reverse"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "password"
    t.string   "email"
    t.integer  "usergroup_id"
    t.integer  "admingroup_id"
    t.string   "regip"
    t.string   "lastloginip"
    t.integer  "readnum"
    t.integer  "viewnum"
    t.integer  "onlinetime"
    t.integer  "credit"
    t.integer  "credit1"
    t.integer  "credit2"
    t.integer  "credit3"
    t.integer  "credit4"
    t.integer  "credit5"
    t.integer  "credit6"
    t.integer  "credit7"
    t.integer  "credit8"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
