module Domain
  module Test_Pyramid_Domain
    def view_pyramid_view(sub_proj)
      navigate_to_homepage()
      go_to_url(TEST_PYRAMID_PAGE)
      fill_pyramid_data(sub_proj)
    end

    def verify_pyramid_display(subproject)
      wait_until_for { page.has_css?(PYRAMID_ID) }
      assert page.has_css?(PYRAMID_ID), "Pyramid is displayed"
      wait_until_for { page.has_content?("Test-Pyramid for: "+subproject) }
      assert page.has_content?("Test-Pyramid for: "+subproject), "Title is displayed"
    end

    def verify_pyramid_table_display(subproject)
      wait_until_for { page.has_css?(PYRAMID_TABLE_ID) }
      assert page.has_css?(PYRAMID_TABLE_ID), "Pyramid table is displayed"
      verify_if_no_of_rows_equals_no_of_blocks_in_pyramid()
    end
  end
end

World(Domain::Test_Pyramid_Domain)

