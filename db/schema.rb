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

ActiveRecord::Schema.define(:version => 20130515021903) do

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "photos_count"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "head_url"
  end

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "conversations", :force => true do |t|
    t.integer  "conversationer_id"
    t.string   "conversationer_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "dynamic_statuses", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "extra_infos", :force => true do |t|
    t.string   "visitors"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "counts"
    t.integer  "occupied_days"
  end

  add_index "extra_infos", ["user_id"], :name => "index_extra_infos_on_user_id"

  create_table "feeds", :force => true do |t|
    t.string   "feedable_type"
    t.integer  "feedable_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "group_groupships", :force => true do |t|
    t.integer  "applied_group_id"
    t.integer  "target_group_id"
    t.string   "time"
    t.string   "location"
    t.string   "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "status"
    t.string   "activity"
  end

  create_table "group_invitationships", :force => true do |t|
    t.string   "applied_group_id"
    t.string   "status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "invitation_id"
    t.string   "description"
  end

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  add_index "group_memberships", ["group_id", "member_id"], :name => "index_group_memberships_on_group_id_and_member_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "team_leader_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "member_counts"
    t.string   "sex"
    t.string   "location"
    t.string   "founded_time"
    t.string   "status"
    t.string   "image"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "initiate_group_id"
    t.string   "time"
    t.string   "location"
    t.string   "description"
    t.string   "status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "activity"
    t.string   "image"
    t.string   "invitation_type"
    t.string   "fee"
  end

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "photo_comments", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content"
    t.integer  "photo_id"
    t.string   "status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "original_comment_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.integer  "album_id"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "number"
  end

  create_table "private_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "content"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "status"
    t.integer  "original_message_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "birthday"
    t.string   "school"
    t.string   "musical_instruments"
    t.string   "books"
    t.string   "sports"
    t.string   "music"
    t.string   "movie"
    t.string   "animation"
    t.string   "games"
    t.string   "telephone"
    t.string   "msn"
    t.string   "qq"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "profession"
    t.string   "sex"
    t.string   "hometown"
    t.string   "location"
    t.string   "status"
    t.string   "avatar"
    t.string   "hobby"
    t.string   "style"
    t.string   "lover_style"
    t.string   "description"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "status"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tips", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "tip_type"
    t.string   "tipable_type"
    t.integer  "tipable_id"
    t.integer  "sender_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.boolean  "sex"
    t.string   "hometown"
    t.string   "location"
    t.string   "status"
    t.string   "captcha"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
