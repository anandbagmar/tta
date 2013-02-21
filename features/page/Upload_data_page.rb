
module Page
  module Upload_dataPage


    def navigate_to_upload_page
      go_to_url(UPLOAD_PAGE)
    end

    def go_to_url(button)
      clickButton(button)
    end
  end
end

World(Page::Upload_dataPage)