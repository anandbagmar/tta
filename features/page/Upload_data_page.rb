
module Page
  module Upload_dataPage

    def fill_the_form(table)
      table.hashes.each do |row|
        navigate_to_homepage
        navigate_to_upload_page
        upload_data(row)
        submit_form()
      end
    end

    def submit_form()
      clickButton(UPLOAD_PAGE_BUTTON)
      verify_data_uploaded(UPLOAD_SUCCESS)
    end

    def verify_data_uploaded(proj_succ)
      assert page_has_content?(proj_succ),"No Project uploaded"
    end
  end
end

World(Page::Upload_dataPage)
