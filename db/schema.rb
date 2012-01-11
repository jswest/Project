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

ActiveRecord::Schema.define(:version => 20120111194414) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "abstract"
    t.text     "full_text"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "first_paragraph"
  end

  create_table "saved_articles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_articles", :force => true do |t|
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shared_by"
    t.integer  "article_id"
  end

  create_table "shared_articles_users", :id => false, :force => true do |t|
    t.integer "shared_article_id", :null => false
    t.integer "user_id",           :null => false
  end

  add_index "shared_articles_users", ["shared_article_id", "user_id"], :name => "index_shared_articles_users_on_shared_article_id_and_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password_digest"
  end

end
