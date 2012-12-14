#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

task :default => :spec

Tta::Application.load_tasks


task :upload ,[:project_name, :sub_project_name, :ci_job_name, :test_category, :test_report_type, :os_name, :host_name, :browser, :type_of_environment, :date_of_execution, :logDirectory, :filePattern, :commit]  do |t,args|
  args.with_defaults(:project_name => "xyz112", :sub_project_name =>   "xyz", :ci_job_name => "xyz", :test_category => "xyz", :test_report_type => "xyz", :os_name => "xyz", :host_name => "xyz", :browser => "xyz", :type_of_environment => "xyz", :date_of_execution => "1900-12-12" , :logDirectory => "asdw" , :filePattern => "*.xml", :commit => "SUBMIT")

  `curl --request GET '10.12.6.92:3000/upload/create?utf8=%E2%9C%93&project_name=#{args.project_name}&sub_project_name=#{args.sub_project_name}&ci_job_name=#{args.ci_job_name}&test_category=#{args.test_category}&test_report_type=#{args.test_report_type}&os_name=#{args.os_name}&host_name=#{args.host_name}&browser=#{args.browser}&type_of_environment=#{args.type_of_environment}&test_metadatum%5Bdate_of_execution%5D=#{args.date_of_execution}&logDirectory=#{args.logDirectory}&filePattern=#{args.filePattern}&commit=#{args.commit}'`


end

