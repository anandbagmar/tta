module Domain
  module AdminPage
    def verify_product_information_display()
      assert page.has_content? ("PROJECT NAME")
    end
  end
end

World(Domain::AdminPage)