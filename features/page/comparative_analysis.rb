module Page
  module ComparativeAnalysis
    def view_graph(product, platform, start_date, end_date)
      fill_in COMPARATIVE_START_DATE, :with => start_date
      fill_in COMPARATIVE_END_DATE, :with => end_date

      select_the_option(product, COMPARATIVE_PRODUCT_DROPDOWN)
      select_the_option(platform, COMPARATIVE_PLATFORM_DROPDOWN)
      scroll_to_view_and_click_on(COMPARATIVE_PLOT_BUTTON)
    end
  end
end

World(Page::ComparativeAnalysis)