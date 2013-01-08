module Definitions
  module Basic_definitions
    def form_filling(test_type)
      fill_in 'project_name', :with => "Project1"
      fill_in 'sub_project_name', :with => "SubProj1"
      fill_in 'ci_job_name', :with => "Run unit test"
      fill_in 'os_name', :with => "Mac"
      fill_in 'host_name', :with => "Khushal"
      fill_in 'browser', :with => "IE"
      fill_in 'type_of_environment', :with => "DEV"
      fill_in 'date_of_execution', :with => "2011-12-12"
      attach_file 'logDirectory', "/var/lib/go-agent/pipelines/Development/tta_spec_results.zip"
      select test_type, :from => "test_category"
      click_button("SUBMIT")

    end
  end
end
World(Definitions::Basic_definitions)
