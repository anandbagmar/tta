#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Tta::Application.load_tasks

task :default => :unit_test


$project_name='TTA'
$sub_project_name='TTA'
$test_report_type= 'JUnit'
$os_name='Linux'
$host_name='Go-Server'
$date_of_execution='2012-12-14'
$commit= "SUBMIT"

task :db_setup do
  Rake::Task['db:drop'].execute
  Rake::Task['db:create'].execute
  Rake::Task['db:migrate'].execute
end

task :unit_test do
  Rake::Task['db_setup'].execute
  Rake::Task['spec'].execute
  Rake::Task['upload_to_tta[GO_JOB_NAME,Unit Test,"",dev,/Users/pooja/Documents/tta/logs/proj4,*.xml]'].execute

end

task :upload_to_tta ,[:ci_job_name, :test_category, :browser, :type_of_environment, :logDirectory, :filePattern]  do |t,args|
    args.with_defaults(:ci_job_name => "xyz", :test_category => "xyz", :browser => "xyz", :type_of_environment => "xyz", :logDirectory => "asdw" , :filePattern => "*.xml")

    `curl --request GET '10.12.6.92:3000/upload/create?utf8=%E2%9C%93&project_name=#{$project_name}&sub_project_name=#{$sub_project_name}&ci_job_name=#{args.ci_job_name}&test_category=#{args.test_category}&test_report_type=#{$test_report_type}&os_name=#{$os_name}&host_name=#{$host_name}&browser=#{args.browser}&type_of_environment=#{args.type_of_environment}&test_metadatum%5Bdate_of_execution%5D=#{$date_of_execution}&logDirectory=#{args.logDirectory}&filePattern=#{args.filePattern}&commit=#{$commit}'`

  end



