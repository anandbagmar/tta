#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Tta::Application.load_tasks
namespace :db do
  namespace :test do
    task :load => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end

$project_name=""
$sub_project_name=""
$ci_job_name=""
$test_category=""
$test_report_type=""
$os_name=""
$host_name=""
$browser=""
$type_of_environment=""
$date_of_execution=""
$log_directory=""
$file_pattern=""
$commit=""

# Set the RAILS_ENV
$RAILS_ENV = ENV['RAILS_ENV']  ||= "test"
puts "RAILS_ENV: #{$RAILS_ENV}"

task :default => 'tta:unit_tests'

namespace :db do
  desc "Seed large data in DB"
  task :large_data => ['db:recreate'] do
    puts "creating a large database"
    load($PROJECT_ROOT+"/db/large_data.rb")
  end

  desc "setup the database by drop & create & migrate"
  task :recreate do
    puts "recreate #{ENV['RAILS_ENV']} env"
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end

namespace :tta do
  desc "Run unit_tests"
  task :unit_tests do
    Rake::Task['db:recreate'].execute
    Rake::Task['spec'].execute
    Rake::Task['tta:upload_to_tta'].invoke("TTA_ON_GO", "TTA_subproject", "Build1", "UnitTest", "JUnit", "Ubuntu", "Pooja-pc", "Chrome", "Prod", "", "/Users/pooja/Documents/tta/logs/proj4", "*.xml")
  end

  task :upload_to_tta, [:project_name, :sub_project_name, :ci_job_name, :test_category, :test_report_type, :os_name, :host_name, :browser, :type_of_environment, :date_of_execution, :logDirectory, :filePattern, :commit] do |t, args|
    args.with_defaults(:project_name => "xyz112", :sub_project_name => "xyz", :ci_job_name => "xyz", :test_category => "xyz", :test_report_type => "xyz", :os_name => "xyz", :host_name => "xyz", :browser => "xyz", :type_of_environment => "xyz", :date_of_execution => "1900-12-12", :logDirectory => "asdw", :filePattern => "*.xml", :commit => "SUBMIT")
    $project_name = args.project_name
    $sub_project_name = args.sub_project_name
    $ci_job_name = ENV['GO_JOB_NAME']
    $test_category=args.test_category
    $test_report_type=args.test_report_type
    $os_name=RUBY_PLATFORM
    $host_name=`hostname`.strip
    $browser=args.browser
    $type_of_environment=args.type_of_environment
    $date_of_execution=(Date.today << 1).to_s
    $log_directory=args.logDirectory
    $file_pattern=args.filePattern
    $commit=args.commit

    #`curl --request GET '10.12.6.154:3000/upload/create?utf8=%E2%9C%93&project_name=#{$project_name}&sub_project_name=#{$sub_project_name}&ci_job_name=#{$ci_job_name}&test_category=#{$test_category}&test_report_type=#{$test_report_type}&os_name=#{$os_name}&host_name=#{$host_name}&browser=#{$browser}&type_of_environment=#{$type_of_environment}&test_metadatum%5Bdate_of_execution%5D=#{$date_of_execution}&logDirectory=#{$log_directory}&filePattern=#{$file_pattern}&commit=SUBMIT'`
  end
end
