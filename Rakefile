#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'date'
# require 'selenium-webdriver'

Tta::Application.load_tasks

Rake::Task['db:migrate'].enhance do
  puts "*** enhance db:migrate scripts"
  Rake::Task['db:after_migrate'].invoke
end

Rake::Task['db:test:prepare'].enhance do
  puts "*** enhance db:test:prepare"
  Rake::Task['db:after_migrate'].invoke
end

namespace :db do
  desc "Basic Seed Data"
  task :seed do
    puts "seeding initial data"
    load("db/demo_seed.rb")
  end

  desc "Seed large data in DB"
  task :large_data => ['db:recreate'] do
    puts "creating a large database"
    load($PROJECT_ROOT+"/db/large_data.rb")
  end

  desc "setup the database by drop & create & migrate"
  task :recreate do
    puts "*** recreate #{ENV['RAILS_ENV']} env"
    puts "*** dropping db"
    Rake::Task['db:drop'].invoke
    puts "*** creating db"
    Rake::Task['db:create'].execute
    puts "*** running migration scripts"
    Rake::Task['db:migrate'].execute
  end

  task :after_migrate do
    puts "*** adding default test categories"
    load("db/seed_test_category.rb")
  end

end



