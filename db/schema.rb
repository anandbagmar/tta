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

ActiveRecord::Schema.define(:version => 20130220134122) do

  create_table "admins", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "authorization_level"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "sub_projects", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_case_records", :force => true do |t|
    t.string   "class_name"
    t.string   "time_taken"
    t.integer  "test_suite_record_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.text     "error_msg"
  end

  add_index "test_case_records", ["test_suite_record_id"], :name => "index_test_case_records_on_test_suite_record_id"

  create_table "test_metadata", :force => true do |t|
    t.integer  "sub_project_id"
    t.string   "ci_job_name"
    t.string   "os_name"
    t.string   "host_name"
    t.string   "browser"
    t.string   "type_of_environment"
    t.datetime "date_of_execution"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "test_category"
    t.string   "test_report_type"
  end

  create_table "test_suite_records", :force => true do |t|
    t.integer  "test_metadatum_id"
    t.string   "class_name"
    t.integer  "number_of_tests"
    t.integer  "number_of_errors"
    t.integer  "number_of_failures"
    t.string   "time_taken"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "number_of_tests_not_run"
    t.integer  "number_of_tests_ignored"
  end

end
