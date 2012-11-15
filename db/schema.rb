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

ActiveRecord::Schema.define(:version => 20121115140257) do

  create_table "j_unit_xmls", :force => true do |t|
    t.string   "name"
    t.text     "contentxml"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "junit_xml_data", :force => true do |t|
    t.string   "name"
    t.string   "classname"
    t.string   "tests"
    t.string   "failures"
    t.string   "errorsintest"
    t.string   "hostname"
    t.string   "timetaken"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "project_details", :force => true do |t|
    t.string   "Name"
    t.string   "Log_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "unit_test_xmls", :force => true do |t|
    t.string   "xml_file_name"
    t.string   "xml_content_type"
    t.string   "xml_file_size"
    t.datetime "xml_updated_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
