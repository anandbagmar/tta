# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_case_record do
    class_name "MyString"
    time_taken "MyString"
    test_suite_record nil
  end
end
