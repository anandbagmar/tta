class TestCaseRecord < ActiveRecord::Base
  belongs_to :test_suite_record
  attr_accessible :test_suite_record_id, :class_name, :time_taken, :error_msg, :status

  def self.get_test_case_records_with_error(test_suite_records)
    test_suite_records_ids = get_record_ids_for(test_suite_records)
    TestCaseRecord.find_by_sql("#{get_class_names_for(test_suite_records_ids)} order by class_name")
  end

  def self.get_common_test_case_records_with_errors_in_two_dates(test_suite_records_for_date_one, test_suite_records_for_date_two)
    test_suite_record_ids_for_date_one = get_record_ids_for(test_suite_records_for_date_one)
    test_suite_record_ids_for_date_two = get_record_ids_for(test_suite_records_for_date_two)

    TestCaseRecord.find_by_sql(
        "select class_name from
      (#{get_class_names_for(test_suite_record_ids_for_date_one)}) test_case_records_one
        Inner join
      (#{get_class_names_for(test_suite_record_ids_for_date_two)}) test_case_records_two
        USING(class_name) order by class_name")
  end

  def self.get_combined_test_case_records_with_errors_in_two_dates(test_suite_records_for_date_one, test_suite_records_for_date_two)
    test_suite_record_ids_for_date_one = get_record_ids_for(test_suite_records_for_date_one)
    test_suite_record_ids_for_date_two = get_record_ids_for(test_suite_records_for_date_two)

    TestCaseRecord.find_by_sql("#{get_class_names_for(test_suite_record_ids_for_date_one)}
      UNION #{get_class_names_for(test_suite_record_ids_for_date_two)}")
  end

  def self.get_class_names_for test_suite_record_ids
    "select class_name from test_case_records where test_suite_record_id IN (#{test_suite_record_ids}) AND error_msg <> ''"
  end

  def eql?(other)
    self.class_name == other.class_name
  end

  def self.get_record_ids_for(records)
    records.map { |record| record.id }.join(',')
  end

  def self.create_and_save(hash)
    test_case = TestCaseRecord.new(hash)
    test_case.save
    test_case
  end

end