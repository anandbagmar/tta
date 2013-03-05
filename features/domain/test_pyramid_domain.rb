module Domain
  module Test_Pyramid_Domain

    def view_pyramid_view(sub_proj)
      navigate_to_homepage()
      go_to_url(TEST_PYRAMID_PAGE)
      fill_pyramid_data(sub_proj)
    end

    def verify_pyramid_display(subproject)
      wait_until_for { page.has_css?(PYRAMID_ID) }
      assert page.has_css?(PYRAMID_ID),"Pyramid is displayed"
      wait_until_for { page.has_content?("Test-Pyramid for: "+subproject) }
      assert page.has_content?("Test-Pyramid for: "+subproject),"Title is displayed"
    end
  end
end

World(Domain::Test_Pyramid_Domain)

