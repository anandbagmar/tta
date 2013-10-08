#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'date'
require_relative 'features/support/monkey_patches/cukeforker.rb'
require 'cukeforker-webdriver'
require 'selenium-webdriver'

Tta::Application.load_tasks

Rake::Task['db:create'].enhance do
  Rake::Task['db:after_create'].invoke
end

task :parallel_run_ttv do
  CukeForker::WebDriver::Runner.run(
      CukeForker::Scenarios.tagged(%W[@ttv]),
      :max=>4,
      :out => "log/tta_cukes_result/html",
      :extra_args => %w[--format CukeForker::Formatters::JunitScenarioFormatter --out  log/tta_cukes_result]

  )
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
$date=""
$log_directory=""
$file_pattern=""
$commit=""
$file_uploaded=""

# Set the RAILS_ENV
$RAILS_ENV = ENV['RAILS_ENV']
puts "RAILS_ENV: #{$RAILS_ENV}"

task(:default).clear
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

  task :after_create do
    #load("db/seed_test_category.rb")
  end

end

namespace :tta do
  desc "Run unit_tests"
  task :unit_tests =>['db:drop','db:create','db:migrate','spec']

  desc "Upload all artifacts"
  task :upload_artifacts,[:test_type,:file_path,:test_report_type] do |t,args|
    Rake::Task['tta:upload_to_tta'].invoke("TTA", "TTA_sub", "Build", args.test_type, args.test_report_type, "Ubuntu", "host-pc", "none", "Dev", "", args.file_path, "*.xml")
  end
  task :create_cucumber_zip do
    `zip cucumber_results.zip log/tta_cukes_result/*.xml`
  end
  task :create_zip do
    `zip tta_spec_results.zip log/tta_spec_results.xml`
  end

  task :upload_to_tta, [:project_name, :sub_project_name, :ci_job_name, :test_category, :test_report_type, :os_name, :host_name, :browser, :type_of_environment, :date_of_execution, :logDirectory, :filePattern, :commit] do |t, args|
    args.with_defaults(:project_name => "demoProject", :sub_project_name => "demoSubProject", :ci_job_name => "demoCIJob", :test_category => "Unit Test", :test_report_type => "Junit", :os_name => "MAc", :host_name => "xyz", :browser => "Chrome", :type_of_environment => "Dev", :date_of_execution => "1900-12-12", :logDirectory => "asdw", :filePattern => "*.xml", :commit => "SUBMIT")
    $project_name = args.project_name
    $sub_project_name = args.sub_project_name
    $ci_job_name = ENV['GO_JOB_NAME']
    $test_category=args.test_category
    $test_report_type=args.test_report_type
    $os_name=RUBY_PLATFORM
    $host_name=`hostname`.strip
    $browser=args.browser
    $type_of_environment=args.type_of_environment
    $log_directory=args.logDirectory
    $file_pattern=args.filePattern
    $commit=args.commit
    `curl -F 'authenticity_token=KBc5IruWAILeOOIVKoqozwSYx3eSatES/fklIGf/Cn4=' -F 'project_name=#{$project_name}' -F 'sub_project_name=#{$sub_project_name}' -F 'ci_job_name=#{$ci_job_name}' -F 'test_category=#{$test_category}' -F 'test_report_type=#{$test_report_type}' -F 'os_name=#{$os_name}' -F 'host_name=#{$host_name}' -F 'browser=#{$browser}' -F 'type_of_environment=#{$type_of_environment}' -F 'date="" ' -F 'logDirectory=@#{$log_directory}' -F 'commit=SUBMIT' 'tta.thoughtworks.com:3000/upload/automatic'`
  end
end



