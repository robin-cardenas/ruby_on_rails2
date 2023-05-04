# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_02_213104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.bigint "document"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "payroll_details", force: :cascade do |t|
    t.string "concept"
    t.bigint "valor"
    t.integer "type"
    t.float "percentage"
    t.bigint "payroll_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payroll_id"], name: "index_payroll_details_on_payroll_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.bigint "income"
    t.bigint "deductions"
    t.bigint "social_security"
    t.bigint "parafiscal_contributions"
    t.bigint "social_benefits"
    t.bigint "employee_pay"
    t.bigint "total_cost"
    t.bigint "employee_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "period_id", null: false
    t.bigint "other_income"
    t.bigint "other_deductions"
    t.bigint "non_salaries"
    t.index ["company_id"], name: "index_payrolls_on_company_id"
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
    t.index ["period_id"], name: "index_payrolls_on_period_id"
  end

  create_table "periods", force: :cascade do |t|
    t.date "initial_date"
    t.date "final_date"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.bigint "base_salary"
    t.date "initial_date"
    t.date "final_date"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "days_period"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "auth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token"
    t.bigint "company_id", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "payroll_details", "payrolls"
  add_foreign_key "payrolls", "companies"
  add_foreign_key "payrolls", "employees"
  add_foreign_key "payrolls", "periods"
  add_foreign_key "salaries", "employees"
  add_foreign_key "users", "companies"
end
