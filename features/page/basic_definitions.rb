module Definitions
  module Basic_definitions
    def form_filling(params)
      fill_in UPLOAD_PRODUCT_NAME, :with => params[:proj]
      fill_in UPLOAD_PLATFORM_NAME, :with => params[:platform]
      fill_in UPLOAD_CI_JOB_NAME, :with => params[:ci_job]
      select params[:test_type], :from => UPLOAD_TEST_TYPE
      select params[:test_sub_type], :from => UPLOAD_TEST_SUB_TYPE
      select params[:test_report_type],:from => UPLOAD_TEST_REPORT_TYPE

      fill_in UPLOAD_OS_NAME, :with => params[:osName]
      fill_in UPLOAD_HOST_NAME, :with => params[:hostName]
      fill_in UPLOAD_BROWSER, :with => params[:browser]
      fill_in UPLOAD_ENV, :with => params[:environment]

      select params[:date_year],:from => UPLOAD_EXEC_YEAR
      select params[:date_month],:from => UPLOAD_EXEC_MONTH
      select params[:date_day],:from => UPLOAD_EXEC_DAY
      select params[:date_hour],:from => UPLOAD_EXEC_HOUR
      select params[:date_minute],:from =>  UPLOAD_EXEC_MIN
      attach_file UPLOAD_FILENAME,params[:logFile]
      #fill_in UPLOAD_TEST_TYPE, :with => params[:test_type]
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