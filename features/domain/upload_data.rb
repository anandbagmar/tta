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

    def upload_data_and_submit(proj_params)
      proj_params[:logFile]=$PROJECT_ROOT+"/"+proj_params[:logFile]
      form_filling(proj_params)
      click_button(UPLOAD_PAGE_BUTTON)
    end

    def verify_data_uploaded(proj_succ)
      assert page.has_content?(proj_succ), "No Project uploaded"
    end
  end
end

World(Domain::UploadData)
