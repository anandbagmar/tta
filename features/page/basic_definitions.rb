module Definitions
  module Basic_definitions

    def form_filling(proj_name,sub_proj_name,ci_job_name,os_name,host_name,browser,type_of_env,year,month,day,hour,min,logFile,test_type)
      fill_in UPLOAD_PROJECT_NAME, :with => proj_name
      fill_in UPLOAD_SUB_PROJECT_NAME, :with => sub_proj_name
      fill_in UPLOAD_CI_JOB_NAME, :with => ci_job_name
      fill_in UPLOAD_OS_NAME, :with => os_name
      fill_in UPLOAD_HOST_NAME, :with => host_name
      fill_in UPLOAD_BROWSER, :with => browser
      fill_in UPLOAD_ENV, :with => type_of_env
      select year ,:from => UPLOAD_EXEC_YEAR
      select month,:from => UPLOAD_EXEC_MONTH
      select day ,:from => UPLOAD_EXEC_DAY
      select hour ,:from => UPLOAD_EXEC_HOUR
      select min ,:from =>  UPLOAD_EXEC_MIN
      attach_file UPLOAD_FILENAME,logFile
      fill_in UPLOAD_TEST_TYPE, :with => test_type
    end


    def select_the_option(field, dropdown)
      select field,:from => dropdown
    end

    def navigate_to_homepage()
      visit HOMEPAGE
    end

    def navigate_to_page(page_name)
      sleep(10)
      click_button(page_name)
    end

    def clickButton(button)
      click_button(button)
    end




    def enter_date(sdate, edate)
      fill_in "comparative_analysis_start_date" ,:with => sdate
      fill_in "comparative_analysis_end_date" , :with => edate
    end

    def fill_in_data(fill_in_id,fill_in_value)
      fill_in fill_in_id ,:with => fill_in_value
    end


    def page_has_css?(element_css)
      assert page.has_css?(element_css),"Nothing displayed"
    end



    def page_has_content?(content)
      sleep(10)
      puts content
        assert page.has_content?(content),"************ No Display ***************"
    end

  end
end
World(Definitions::Basic_definitions)