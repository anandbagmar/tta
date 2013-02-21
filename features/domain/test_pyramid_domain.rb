module Domain
  module Test_Pyramid_Domain

    def view_pyramid_view(sub_proj)
      navigate_to_homepage()
      go_to_url(TEST_PYRAMID_PAGE)
      fill_pyramid_data(sub_proj)
    end

    def verify_pyramid_display(subproject)
      assert page_has_css?(PYRAMID_ID),"Pyramid is displayed"
      assert page_has_content?("Test-Pyramid for: "+subproject),"Title is displayed"
      assert verify_if_legends_is_equal_to_divisions, "Legend is not displayed correctly"
    end
  end
end

World(Domain::Test_Pyramid_Domain)

