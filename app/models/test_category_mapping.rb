class TestCategoryMapping < ActiveRecord::Base
  attr_accessible :test_category, :test_sub_category
  validates_uniqueness_of :test_sub_category
  validates_presence_of :test_sub_category
  validates_presence_of :test_category

  scope :get_all_test_category_mapping, select("test_category, test_sub_category");

  def get_sub_category(test_category)
    TestCategoryMapping.where(:test_category => test_category).select(:test_sub_category)
  end
end
