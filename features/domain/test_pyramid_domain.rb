module Domain
  module Test_Pyramid_Domain

    def view_pyramid_view(sub_proj)
      navigate_to_pyramid()
      fill_pyramid_data(sub_proj)
    end

    def verify_pyramid_display(sub_proj)
      verify_display(sub_proj)
    end

    def navigate_to_pyramid
      navigate_to_homepage()
      go_to_url(TEST_PYRAMID_PAGE)
    end

  end
end

World(Domain::Test_Pyramid_Domain)