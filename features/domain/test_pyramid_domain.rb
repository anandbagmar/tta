module Domain
  module TestPyramid
    def view_pyramid_view(platform)
      navigate_to_homepage()
      go_to_url(TEST_PYRAMID_PAGE)
      fill_pyramid_data(platform)
    end

    def verify_pyramid_display(platform)
      assert page.has_css?(PYRAMID_ID), "Pyramid is displayed"
      assert page.has_content?("Test-Pyramid for : "+platform), "Title is displayed"
    end

    def verify_pyramid_table_display(platform)
      assert page.has_css?(PYRAMID_TABLE_ID), "Pyramid table is displayed"
      verify_if_no_of_rows_equals_no_of_blocks_in_pyramid()
    end
  end
end

World(Domain::TestPyramid)

