module Definitions
  module Basic_definitions
    def form_filling(proj_name,sub_proj_name,ci_job_name,os_name,host_name,browser,type_of_env,date_of_exec,logDir,test_type)
      fill_in 'project_name', :with => proj_name
      fill_in 'sub_project_name', :with => sub_proj_name
      fill_in 'ci_job_name', :with => ci_job_name
      fill_in 'os_name', :with => os_name
      fill_in 'host_name', :with => host_name
      fill_in 'browser', :with => browser
      fill_in 'type_of_environment', :with => type_of_env
      fill_in 'date_of_execution', :with => date_of_exec
      attach_file 'logDirectory',logDir
      fill_in 'test_category', :with => test_type
      click_button("submit_button")
    end
  end
end
World(Definitions::Basic_definitions)