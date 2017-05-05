module Page
  module DefectAnalysis
    def view_defect_graph(product, platform, testcategory)
      select product, :from => DEFECT_PRODUCT_DROPDOWN
      select platform, :from => DEFECT_PLATFORM_DROPDOWN
      select testcategory, :from => DEFECT_TEST_CATEGORY_DROPDOWN
      page.execute_script %Q{ $("#date").val("2012-01-01");}
      sleep(10)
      click_button(DEFECT_PAGE_BUTTON)
    end
  end
end

World(Page::DefectAnalysis)