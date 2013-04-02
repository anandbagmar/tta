module Page
  module UploadData
    def navigate_to_upload_page
      go_to_url(UPLOAD_PAGE)
    end

    def go_to_url(button)
      click_button(button)
    end
  end
end

World(Page::UploadData)