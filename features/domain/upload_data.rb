module Domain
  module UploadData
    def upload_the_data(table)
      fill_the_form(table)
    end

    def fill_the_form(table)
      table.hashes.each do |row|
        navigate_to_homepage
        navigate_to_upload_page
        upload_data_and_submit(row)
        verify_data_uploaded(UPLOAD_SUCCESS)
      end
    end

    def upload_data_and_submit(params)
      begin
        params[:logFile]=$PROJECT_ROOT+"/"+params[:logFile]
        form_filling(params)
        scroll_to_view_and_click_on UPLOAD_PAGE_BUTTON
      rescue Exception => ex
        # puts "Exception in uploading data. \n\t" + ex.inspect
        file_name = "screenshot_"+random_name+".png"
        save_error_screenshot(file_name)
        throw ex
      end
    end

    def verify_data_uploaded(upload_succeeded_message)
      assert page.has_content?(upload_succeeded_message), "No Product uploaded"
    end
  end
end

World(Domain::UploadData)
