class Symbol
  def as value
    hash       = {}
    hash[self] = value
    hash
  end
end

module DataHelper

  def create(*args)
    FactoryGirl.create(*args)
  end

  def with(*args)
    result_hash = {}
    args.each do |hash|
      hash.each_key do |key|
        result_hash[key] = hash[key]
      end
    end
    result_hash
  end

  def create_product(arg_name="TEST_PRODUCT")
    create :product,
           with(
               :name.as(arg_name)
           )
  end

  def create_platform_for_product(arg_product, arg_name="TESTS_PLATFORM")
    create :platform,
           with(
               :name.as(arg_name),
               :product_id.as(arg_product.id)
           )
  end

  def create_other_platform_for_product(arg_product, arg_name="TESTS_PLATFORM_OTHER")
    create :platform,
           with(
               :name.as(arg_name),
               :product_id.as(arg_product.id)
           )
  end

  def create_metadatum(arg_platform, arg_date, arg_test_category="INTEGRATION TESTS", arg_branch="master")
    create :test_metadatum,
           with(
               :platform_id.as(arg_platform.id),
               :date_of_execution.as(arg_date),
               :test_category.as(arg_test_category),
               :branch.as(arg_branch)
           )
  end

  def create_suite_with_metadata(arg_metadata, arg_class_name="Class001")
    create :test_suite_records,
           with(
               :test_metadatum_id.as(arg_metadata.id),
               :class_name.as(arg_class_name)
           )
  end

  def add_failed_tests_from_suite(arg_suite, arg_class_name="Class001_1", arg_err_msg="error001_1")
    create :test_case_record,
           with(
               :test_suite_record_id.as(arg_suite.id),
               :class_name.as(arg_class_name),
               :error_msg.as(arg_err_msg)
           )
  end

  def get_metadata(arg_platform, arg_test_category, arg_date)
    TestMetadatum.get_record_for_specific_date(
        arg_platform.id,
        arg_test_category,
        arg_date)
  end

end
