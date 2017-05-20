module Page
  module DefectAnalysis
    def view_defect_graph(product, platform, test_category, date)
      select product, :from => DEFECT_PRODUCT_DROPDOWN
      select platform, :from => DEFECT_PLATFORM_DROPDOWN
      select test_category, :from => DEFECT_TEST_CATEGORY_DROPDOWN
      fill_in 'date', :with => date
      find(DEFECT_FORM).click
      sleep(10)
      click_button(DEFECT_PAGE_BUTTON)
    end
  end
end

World(Page::DefectAnalysis)