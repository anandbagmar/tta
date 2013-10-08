class TestCategoryMapping < ActiveRecord::Base
  attr_accessible :test_category, :test_sub_category

  def get_sub_category(test_category)
    TestCategoryMapping.where(:test_category => test_category).select(:test_sub_category)
  end
end
