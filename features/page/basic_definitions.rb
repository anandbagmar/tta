module Definitions
  module Basic_definitions
    def form_filling(proj_params)
      fill_in UPLOAD_PROJECT_NAME, :with => proj_params[:proj]
      fill_in UPLOAD_SUB_PROJECT_NAME, :with => proj_params[:sub_proj]
      fill_in UPLOAD_CI_JOB_NAME, :with => proj_params[:ci_job]
      select proj_params[:test_type], :from => UPLOAD_TEST_TYPE
      select proj_params[:test_sub_type], :from => UPLOAD_TEST_SUB_TYPE
      select proj_params[:test_report_type],:from => UPLOAD_TEST_REPORT_TYPE

      fill_in UPLOAD_OS_NAME, :with => proj_params[:osName]
      fill_in UPLOAD_HOST_NAME, :with => proj_params[:hostName]
      fill_in UPLOAD_BROWSER, :with => proj_params[:browser]
      fill_in UPLOAD_ENV, :with => proj_params[:environment]

      select proj_params[:date_year],:from => UPLOAD_EXEC_YEAR
      select proj_params[:date_month],:from => UPLOAD_EXEC_MONTH
      select proj_params[:date_day],:from => UPLOAD_EXEC_DAY
      select proj_params[:date_hour],:from => UPLOAD_EXEC_HOUR
      select proj_params[:date_minute],:from =>  UPLOAD_EXEC_MIN
      attach_file UPLOAD_FILENAME,proj_params[:logFile]
      #fill_in UPLOAD_TEST_TYPE, :with => proj_params[:test_type]
    end

    def select_the_option(field, dropdown)
      select field,:from => dropdown
    end

    def enter_date(sdate, edate)
      fill_in "comparative_analysis_start_date" ,:with => sdate
      fill_in "comparative_analysis_end_date" , :with => edate
    end

    def fill_in_data(fill_in_id,fill_in_value)
      fill_in fill_in_id ,:with => fill_in_value
    end
  end
end
World(Definitions::Basic_definitions)