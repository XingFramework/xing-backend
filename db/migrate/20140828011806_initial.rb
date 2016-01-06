class Initial < ActiveRecord::Migration
	def self.up

	  # These are extensions that must be enabled in order to support this database
	  enable_extension "plpgsql"
	  enable_extension "hstore"

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
