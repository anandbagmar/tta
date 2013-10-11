TESTCATEGORYMAPPINGS = YAML.load(File.open("#{Rails.root}/config/test_category_mapping.yml", "r"))
TESTCATEGORYMAPPINGS.each do |testCategoryMapping|
  test_category = testCategoryMapping.first
  TESTCATEGORYMAPPINGS[test_category].each do |test_sub_category|
    TestCategoryMapping.create(:test_category => test_category.upcase, :test_sub_category => test_sub_category.upcase)
  end
end

