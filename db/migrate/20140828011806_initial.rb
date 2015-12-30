class Initial < ActiveRecord::Migration
	def self.up

	  # These are extensions that must be enabled in order to support this database
	  enable_extension "plpgsql"
	  enable_extension "hstore"

	  create_table "content_blocks", force: true do |t|
	    t.string   "content_type"
	    t.text     "body"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  create_table "documents", force: true do |t|
	    t.string   "data_file_name"
	    t.integer  "data_file_size"
	    t.string   "data_content_type"
	    t.datetime "data_updated_at"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  create_table "images", force: true do |t|
	    t.string   "image_file_name"
	    t.integer  "image_file_size"
	    t.string   "image_content_type"
	    t.datetime "image_updated_at"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  create_table "menu_items", force: true do |t|
	    t.string   "name"
	    t.string   "path"
	    t.integer  "parent_id"
	    t.integer  "lft"
	    t.integer  "rgt"
	    t.integer  "page_id"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  create_table "page_contents", force: true do |t|
	    t.integer  "page_id"
	    t.integer  "content_block_id"
	    t.string   "name"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  add_index "page_contents", ["content_block_id"], name: "index_page_contents_on_content_block_id", using: :btree
	  add_index "page_contents", ["page_id"], name: "index_page_contents_on_page_id", using: :btree

	  create_table "pages", force: true do |t|
	    t.string   "title"
	    t.boolean  "published",        default: true, null: false
	    t.text     "keywords"
	    t.text     "description"
	    t.datetime "edited_at"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.string   "type"
	    t.datetime "publish_start"
	    t.datetime "publish_end"
	    t.hstore   "metadata"
	    t.string   "url_slug"
	    t.datetime "publication_date"
	  end

	  add_index "pages", ["url_slug"], name: "index_pages_on_url_slug", using: :btree

	  create_table "users", force: true do |t|
	    t.string   "login",                  limit: 20,             null: false
	    t.string   "email"
	    t.string   "first_name",             limit: 60
	    t.string   "last_name",              limit: 60
	    t.integer  "sign_in_count",                     default: 0, null: false
	    t.integer  "failed_attempts",                   default: 0, null: false
	    t.datetime "last_request_at"
	    t.datetime "current_sign_in_at"
	    t.datetime "last_sign_in_at"
	    t.string   "current_sign_in_ip"
	    t.string   "last_sign_in_ip"
      t.string   "role_name"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.string   "encrypted_password"
	    t.string   "confirmation_token"
	    t.datetime "confirmed_at"
	    t.datetime "confirmation_sent_at"
	    t.string   "reset_password_token"
	    t.datetime "reset_password_sent_at"
	    t.string   "remember_token"
	    t.datetime "remember_created_at"
	    t.string   "unlock_token"
	    t.datetime "locked_at"
	  end

	  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
	  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
	  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
	  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

	end

	def self.down
    raise ActiveRecord::IrreversibleMigration
	end
end
