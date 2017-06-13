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

ActiveRecord::Schema.define(version: 20170613115356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "to_id"
    t.string   "to_type"
    t.string   "from_type"
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "albums", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "campains", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "slug"
    t.string   "avatar"
    t.index ["organization_id"], name: "index_campains_on_organization_id", using: :btree
    t.index ["slug"], name: "index_campains_on_slug", using: :btree
    t.index ["user_id"], name: "index_campains_on_user_id", using: :btree
  end

  create_table "chatroom_users", force: :cascade do |t|
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "last_read_at"
    t.index ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_chatroom_users_on_user_id", using: :btree
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "direct_message", default: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "campain_id"
    t.string   "avatar"
    t.string   "slug"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "description"
    t.index ["campain_id"], name: "index_events_on_campain_id", using: :btree
    t.index ["slug"], name: "index_events_on_slug", using: :btree
  end

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["interest_id"], name: "index_interests_lists_on_interest_id", using: :btree
    t.index ["user_id"], name: "index_interests_lists_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.string   "activity_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "country"
    t.string   "city"
    t.string   "accentcity"
    t.string   "region"
    t.integer  "population"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "role"
    t.index ["organization_id"], name: "index_members_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subscriptions_quota_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "user_id"
    t.string   "action"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "read",            default: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "owner_id"
    t.string   "slug"
    t.string   "avatar"
    t.string   "description"
    t.boolean  "removed",     default: false
    t.index ["owner_id"], name: "index_organizations_on_owner_id", using: :btree
    t.index ["slug"], name: "index_organizations_on_slug", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "caption"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "picture"
    t.index ["album_id"], name: "index_pictures_on_album_id", using: :btree
    t.index ["user_id"], name: "index_pictures_on_user_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string  "name"
    t.integer "organizations_quota"
    t.integer "campains_quota"
    t.integer "events_quota"
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "statusable_type"
    t.integer  "statusable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["statusable_id", "statusable_type"], name: "index_statuses_on_statusable_id_and_statusable_type", using: :btree
    t.index ["statusable_type", "statusable_id"], name: "index_statuses_on_statusable_type_and_statusable_id", using: :btree
  end

  create_table "subscriptions_quota", force: :cascade do |t|
    t.string   "plan"
    t.integer  "organizations_quota"
    t.integer  "campains_quota"
    t.integer  "events_quota"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country_code"
    t.integer  "city_id"
    t.string   "mobile_phone"
    t.string   "gender"
    t.integer  "employee_status"
    t.string   "profile_image"
    t.string   "cover_image"
    t.string   "slug"
    t.string   "avatar"
    t.string   "dob"
    t.string   "street"
    t.string   "zip_code"
    t.string   "activity_status"
    t.string   "qualification"
    t.boolean  "admin"
    t.string   "stripe_id"
    t.string   "stripe_subscription_id"
    t.string   "card_last4"
    t.integer  "card_exp_month"
    t.integer  "card_exp_year"
    t.string   "card_type"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", using: :btree
  end

  create_table "users_subscriptions", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscriptions_quota_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "activities", "users"
  add_foreign_key "albums", "users"
  add_foreign_key "campains", "organizations"
  add_foreign_key "campains", "users"
  add_foreign_key "chatroom_users", "chatrooms"
  add_foreign_key "chatroom_users", "users"
  add_foreign_key "events", "campains"
  add_foreign_key "interests_lists", "interests"
  add_foreign_key "interests_lists", "users"
  add_foreign_key "members", "organizations"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "organizations", "users", column: "owner_id"
  add_foreign_key "pictures", "albums"
  add_foreign_key "pictures", "users"
end
