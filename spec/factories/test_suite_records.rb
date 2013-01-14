FactoryGirl.define do
  factory :test_suite_records, :class => TestSuiteRecord do
    association :test_metadatum_id, :factory => :test_metadatum, :strategy => :build
    class_name "class001"
    number_of_tests "10"
    number_of_errors "2"
    number_of_failures "4"
    time_taken "2"
  end
end