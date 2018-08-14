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

ActiveRecord::Schema.define(version: 20180805194252) do

  create_table "account_versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.integer  "account_id"
    t.integer  "reason"
    t.decimal  "balance",         precision: 32, scale: 16
    t.decimal  "locked",          precision: 32, scale: 16
    t.decimal  "fee",             precision: 32, scale: 16
    t.decimal  "amount",          precision: 32, scale: 16
    t.string   "modifiable_type"
    t.integer  "modifiable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency"
    t.integer  "fun"
    t.index ["account_id", "reason"], name: "index_account_versions_on_account_id_and_reason", using: :btree
    t.index ["account_id"], name: "index_account_versions_on_account_id", using: :btree
    t.index ["member_id", "reason"], name: "index_account_versions_on_member_id_and_reason", using: :btree
    t.index ["modifiable_id", "modifiable_type"], name: "index_account_versions_on_modifiable_id_and_modifiable_type", using: :btree
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "balance",                         precision: 32, scale: 16
    t.decimal  "locked",                          precision: 32, scale: 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "in",                              precision: 32, scale: 16
    t.decimal  "out",                             precision: 32, scale: 16
    t.integer  "default_withdraw_fund_source_id"
    t.index ["member_id", "currency"], name: "index_accounts_on_member_id_and_currency", using: :btree
    t.index ["member_id"], name: "index_accounts_on_member_id", using: :btree
  end

  create_table "api_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id",                        null: false
    t.string   "access_key",            limit: 50, null: false
    t.string   "secret_key",            limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trusted_ip_list"
    t.string   "label"
    t.integer  "oauth_access_token_id"
    t.datetime "expire_at"
    t.string   "scopes"
    t.datetime "deleted_at"
    t.index ["access_key"], name: "index_api_tokens_on_access_key", unique: true, using: :btree
    t.index ["secret_key"], name: "index_api_tokens_on_secret_key", unique: true, using: :btree
  end

  create_table "assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "type"
    t.integer "attachable_id"
    t.string  "attachable_type"
    t.string  "file"
  end

  create_table "audit_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.string   "source_state"
    t.string   "target_state"
    t.index ["auditable_id", "auditable_type"], name: "index_audit_logs_on_auditable_id_and_auditable_type", using: :btree
    t.index ["operator_id"], name: "index_audit_logs_on_operator_id", using: :btree
  end

  create_table "authentications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.index ["member_id"], name: "index_authentications_on_member_id", using: :btree
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.integer  "author_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "amount",                 precision: 32, scale: 16
    t.decimal  "fee",                    precision: 32, scale: 16
    t.string   "fund_uid"
    t.string   "fund_extra"
    t.string   "txid"
    t.integer  "state"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "done_at"
    t.string   "confirmations"
    t.string   "type"
    t.integer  "payment_transaction_id"
    t.integer  "txout"
    t.index ["txid", "txout"], name: "index_deposits_on_txid_and_txout", using: :btree
  end

  create_table "document_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "document_id",               null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "title"
    t.text     "body",        limit: 65535
    t.text     "desc",        limit: 65535
    t.text     "keywords",    limit: 65535
    t.index ["document_id"], name: "index_document_translations_on_document_id", using: :btree
    t.index ["locale"], name: "index_document_translations_on_locale", using: :btree
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key"
    t.string   "title"
    t.text     "body",       limit: 65535
    t.boolean  "is_auth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "desc",       limit: 65535
    t.text     "keywords",   limit: 65535
  end

  create_table "fund_sources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.integer  "currency"
    t.string   "extra"
    t.string   "uid"
    t.boolean  "is_locked",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "id_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "id_document_type"
    t.string   "name"
    t.string   "id_document_number"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birth_date"
    t.text     "address",            limit: 65535
    t.string   "city"
    t.string   "country"
    t.string   "zipcode"
    t.integer  "id_bill_type"
    t.string   "aasm_state"
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_active"
    t.integer  "retry_count"
    t.boolean  "is_locked"
    t.datetime "locked_at"
    t.datetime "last_verify_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ask_unit",      limit: 5,                                         null: false
    t.string   "bid_unit",      limit: 5,                                         null: false
    t.decimal  "ask_fee",                 precision: 7, scale: 6, default: "0.0", null: false
    t.decimal  "bid_fee",                 precision: 7, scale: 6, default: "0.0", null: false
    t.integer  "ask_precision", limit: 1,                         default: 4,     null: false
    t.integer  "bid_precision", limit: 1,                         default: 4,     null: false
    t.integer  "position",                                        default: 0,     null: false
    t.boolean  "visible",                                         default: true,  null: false
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.index ["ask_unit", "bid_unit"], name: "index_markets_on_ask_unit_and_bid_unit", unique: true, using: :btree
    t.index ["ask_unit"], name: "index_markets_on_ask_unit", using: :btree
    t.index ["bid_unit"], name: "index_markets_on_bid_unit", using: :btree
    t.index ["position"], name: "index_markets_on_position", using: :btree
    t.index ["visible"], name: "index_markets_on_visible", using: :btree
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sn"
    t.string   "display_name"
    t.string   "email"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state"
    t.boolean  "activated"
    t.integer  "country_code"
    t.string   "phone_number"
    t.boolean  "disabled",     default: false
    t.boolean  "api_disabled", default: false
    t.string   "nickname"
  end

  create_table "oauth_access_grants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_owner_id",               null: false
    t.integer  "application_id",                  null: false
    t.string   "token",                           null: false
    t.integer  "expires_in",                      null: false
    t.text     "redirect_uri",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.datetime "deleted_at"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                       null: false
    t.string   "uid",                        null: false
    t.string   "secret",                     null: false
    t.text     "redirect_uri", limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "bid"
    t.integer  "ask"
    t.string   "market_id",      limit: 10
    t.decimal  "price",                     precision: 32, scale: 16
    t.decimal  "volume",                    precision: 32, scale: 16
    t.decimal  "origin_volume",             precision: 32, scale: 16
    t.integer  "state"
    t.datetime "done_at"
    t.string   "type",           limit: 8
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sn"
    t.string   "source",                                                              null: false
    t.string   "ord_type",       limit: 10
    t.decimal  "locked",                    precision: 32, scale: 16
    t.decimal  "origin_locked",             precision: 32, scale: 16
    t.decimal  "funds_received",            precision: 32, scale: 16, default: "0.0"
    t.integer  "trades_count",                                        default: 0
    t.index ["market_id", "state"], name: "index_orders_on_market_id_and_state", using: :btree
    t.index ["member_id", "state"], name: "index_orders_on_member_id_and_state", using: :btree
    t.index ["member_id"], name: "index_orders_on_member_id", using: :btree
    t.index ["state"], name: "index_orders_on_state", using: :btree
  end

  create_table "partial_trees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "proof_id",                 null: false
    t.integer  "account_id",               null: false
    t.text     "json",       limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sum"
  end

  create_table "payment_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency"
  end

  create_table "payment_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "txid"
    t.decimal  "amount",                   precision: 32, scale: 16
    t.integer  "confirmations"
    t.string   "address"
    t.integer  "state"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "receive_at"
    t.datetime "dont_at"
    t.integer  "currency"
    t.string   "type",          limit: 60
    t.integer  "txout"
    t.index ["txid", "txout"], name: "index_payment_transactions_on_txid_and_txout", using: :btree
    t.index ["type"], name: "index_payment_transactions_on_type", using: :btree
  end

  create_table "proofs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "root"
    t.integer  "currency"
    t.boolean  "ready",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sum"
    t.text     "addresses",  limit: 65535
    t.string   "balance",    limit: 30
  end

  create_table "read_marks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "readable_id"
    t.integer  "member_id",                null: false
    t.string   "readable_type", limit: 20, null: false
    t.datetime "timestamp"
    t.index ["member_id"], name: "index_read_marks_on_member_id", using: :btree
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id", using: :btree
  end

  create_table "running_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category"
    t.decimal  "income",      precision: 32, scale: 16, default: "0.0", null: false
    t.decimal  "expenses",    precision: 32, scale: 16, default: "0.0", null: false
    t.integer  "currency"
    t.integer  "member_id"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], name: "index_running_accounts_on_member_id", using: :btree
    t.index ["source_type", "source_id"], name: "index_running_accounts_on_source_type_and_source_id", using: :btree
  end

  create_table "signup_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.string   "ip"
    t.string   "accept_language"
    t.string   "ua"
    t.datetime "created_at"
    t.index ["member_id"], name: "index_signup_histories_on_member_id", using: :btree
  end

  create_table "simple_captcha_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "idx_key", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",    limit: 65535
    t.string   "aasm_state"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token"
    t.datetime "expire_at"
    t.integer  "member_id"
    t.boolean  "is_used",    default: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["type", "token", "expire_at", "is_used"], name: "index_tokens_on_type_and_token_and_expire_at_and_is_used", using: :btree
  end

  create_table "trades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "price",                    precision: 32, scale: 16
    t.decimal  "volume",                   precision: 32, scale: 16
    t.integer  "ask_id"
    t.integer  "bid_id"
    t.integer  "trend"
    t.string   "market_id",     limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ask_member_id"
    t.integer  "bid_member_id"
    t.decimal  "funds",                    precision: 32, scale: 16
    t.index ["ask_id"], name: "index_trades_on_ask_id", using: :btree
    t.index ["ask_member_id"], name: "index_trades_on_ask_member_id", using: :btree
    t.index ["bid_id"], name: "index_trades_on_bid_id", using: :btree
    t.index ["bid_member_id"], name: "index_trades_on_bid_member_id", using: :btree
    t.index ["created_at"], name: "index_trades_on_created_at", using: :btree
    t.index ["market_id"], name: "index_trades_on_market_id", using: :btree
  end

  create_table "two_factors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.string   "otp_secret"
    t.datetime "last_verify_at"
    t.boolean  "activated"
    t.string   "type"
    t.datetime "refreshed_at"
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "item_type",                null: false
    t.integer  "item_id",                  null: false
    t.string   "event",                    null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 65535
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "withdraws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sn"
    t.integer  "account_id"
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "amount",     precision: 32, scale: 16
    t.decimal  "fee",        precision: 32, scale: 16
    t.string   "fund_uid"
    t.string   "fund_extra"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "done_at"
    t.string   "txid"
    t.string   "aasm_state"
    t.decimal  "sum",        precision: 32, scale: 16, default: "0.0", null: false
    t.string   "type"
  end

end
