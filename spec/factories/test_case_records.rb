# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_case_record do
    class_name "Class_01"
    time_taken "5"
  end
end
