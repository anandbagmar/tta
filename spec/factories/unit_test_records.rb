# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unit_test_record do
    project_id 1
    project_metadata_id 1
    class_name "MyString"
    number_of_tests 1
    number_of_errors ""
    number_of_failures 1
    time_taken "MyString"
  end
end
