class TestMetadatum < ActiveRecord::Base

  has_many :test_suite_records
  attr_accessible :ci_job_name, :browser, :type_of_environment, :date_of_execution, :host_name, :os_name, :user_timezone, :test_category, :test_report_type

  validates :browser, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_environment, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :host_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :os_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :date_of_execution, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_category, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_report_type, :presence => {:message => 'cannot be blank, Task not saved'}

  def get_distinct_test_category sub_project_id
    distinct_records = TestMetadatum.find_all_by_sub_project_id(sub_project_id, :select => "DISTINCT(test_category)")
    distinct_records
  end

  def find_no_and_duration_of_test meta_data
    total_num_of_tests = 0
    total_run_time = 0
    total_num_of_failures=0
    meta_data.test_suite_records.each do |test_suite_record|
      total_num_of_tests += test_suite_record.number_of_tests.to_i
      total_run_time += test_suite_record.time_taken.to_f
      total_num_of_failures+= test_suite_record.number_of_failures.to_i
    end
    return total_num_of_tests, total_run_time, total_num_of_failures
  end

  def get_latest_record(sub_project_id, test_category)
    @test_metadata_for_specific_test_category = TestMetadatum.find_all_by_sub_project_id_and_test_category(sub_project_id, test_category)
    latest_test_metadata_record = @test_metadata_for_specific_test_category.sort_by &:date_of_execution
    latest_test_metadata_record.last
  end

  def self.get_record_for_specific_date(sub_project_id, test_category, date)
    metadata_record = TestMetadatum.where(:sub_project_id => sub_project_id, :test_category => test_category, :date_of_execution => date)

    @meta_data = metadata_record
  end
end

