class TestMetadatum < ActiveRecord::Base

  has_many :test_suite_records
  attr_accessible :ci_job_name, :browser, :type_of_environment, :date_of_execution, :host_name, :os_name, :user_timezone, :test_category, :test_report_type ,:test_sub_category

  validates :browser, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_environment, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :host_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :os_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :date_of_execution, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_category, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_sub_category, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_report_type, :presence => {:message => 'cannot be blank, Task not saved'}

  def get_distinct_test_category sub_project_id
    TestMetadatum.where(sub_project_id: sub_project_id).uniq(:test_category)
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
    total_run_time=Time.at(total_run_time).utc.strftime("%H:%M:%S:%L")
    return total_num_of_tests, total_run_time, total_num_of_failures
  end

  def get_latest_record(sub_project_id, test_category)
    @test_metadata_for_specific_test_category = TestMetadatum.where(sub_project_id: sub_project_id, test_category: test_category)
    metadata_records = (@test_metadata_for_specific_test_category.sort_by &:date_of_execution).reverse
    metadata_records.each do |metadata|
      if TestSuiteRecord.where(test_metadatum_id: metadata) != []
        return metadata
      end
    end
    metadata_records.last
  end

  def self.get_record_for_specific_date(sub_project_id, test_category, date)
    @meta_data  = TestMetadatum.where(:sub_project_id => sub_project_id, :test_category => test_category, :date_of_execution => date)
  end
end

