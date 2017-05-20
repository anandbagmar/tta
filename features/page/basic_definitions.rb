module Definitions
  module Basic_definitions
    def form_filling(params)
      fill_in UPLOAD_PRODUCT_NAME, :with => params[:product_name]
      fill_in UPLOAD_PLATFORM_NAME, :with => params[:platform_name]
      fill_in PLATFORM_VERSION, :with => params[:version]
      fill_in BRANCH, :with => params[:branch]
      fill_in UPLOAD_CI_JOB_NAME, :with => params[:ci_job_name]
      fill_in CI_BUILD_NUMBER, :with => params[:ci_build_number]
      fill_in UPLOAD_ENV, :with => params[:environment]
      fill_in UPLOAD_BROWSER_OR_DEVICE, :with => params[:browser_or_device]
      fill_in UPLOAD_OS, :with => params[:os]
      fill_in UPLOAD_TEST_EXECUTION_MACHINE_NAME, :with => params[:host_machine]
      select params[:test_category], :from => UPLOAD_TEST_TYPE
      select params[:test_sub_category], :from => UPLOAD_TEST_SUB_TYPE
      select params[:test_report_type], :from => UPLOAD_TEST_REPORT_TYPE
      select params[:execution_year], :from => UPLOAD_EXEC_YEAR
      select params[:execution_month], :from => UPLOAD_EXEC_MONTH
      select params[:execution_day], :from => UPLOAD_EXEC_DAY
      select params[:execution_hour], :from => UPLOAD_EXEC_HOUR
      select params[:execution_minute], :from => UPLOAD_EXEC_MIN
      attach_file UPLOAD_FILENAME, params[:log_file]
    end

    def select_the_option(field, dropdown)
      select field, :from => dropdown
    end

    def enter_date(sdate, edate)
      fill_in "comparative_analysis_start_date", :with => sdate
      fill_in "comparative_analysis_end_date", :with => edate
    end

    def fill_in_data(fill_in_id, fill_in_value)
      fill_in fill_in_id, :with => fill_in_value
    end
  end
end
World(Definitions::Basic_definitions)