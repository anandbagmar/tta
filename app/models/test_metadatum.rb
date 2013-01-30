class TestMetadatum < ActiveRecord::Base

  has_many :test_suite_records
  attr_accessible :ci_job_name, :browser,:type_of_environment , :date_of_execution, :host_name, :os_name, :user_timezone, :test_category, :test_report_type



  validates :browser, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_environment, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :host_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :os_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :date_of_execution, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_category, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_report_type, :presence => {:message => 'cannot be blank, Task not saved'}



  def self.get_distinct_test_category sub_project_id
    return find_all_by_sub_project_id(sub_project_id, :select => "DISTINCT(test_category)")
  end

  def self.find_no_and_duration_of_test meta_data
     meta_data.inject([]) { |result, metadata_record|
      total_num_of_tests = 0
      total_run_time = 0
      metadata_record.test_suite_records.each do |test_suite_record|
        total_num_of_tests += test_suite_record.number_of_tests.to_i
        total_run_time += test_suite_record.time_taken.to_f
      end
      result << [total_num_of_tests, total_run_time]
       return result
    }
  end
end
