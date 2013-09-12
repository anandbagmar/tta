module Page
  module DefectAnalysis
    def view_defect_graph(project, subproject, testcategory)
      select project, :from => DEFECT_PROJECT_DROPDOWN
      select subproject, :from => DEFECT_SUBPROJECT_DROPDOWN
      select testcategory, :from => DEFECT_TEST_CATEGORY_DROPDOWN
      page.execute_script %Q{ $("#date").val("2012-01-01");}
      sleep(10)
      click_button(DEFECT_PAGE_BUTTON)
    end
  end
end

World(Page::DefectAnalysis)