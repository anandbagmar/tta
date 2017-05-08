# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_case_record, :class => TestCaseRecord do
    association :test_suite_record_id, :factory => :test_suite_records, :strategy => :build
    class_name "Class_01"
    time_taken "5"
    error_msg "ERROR_MSG"
  end
end
