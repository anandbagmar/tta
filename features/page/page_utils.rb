module Page
  module Utils
    def scroll_to_view_and_click_on element_id
      page.execute_script('window.scrollTo(0,100000)')
      click_button element_id
    end
  end
end

World(Page::Utils)