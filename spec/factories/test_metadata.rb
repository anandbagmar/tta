# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_metadatum, :class => 'TestMetadatum' do
    project_id 1
    os_name "MyString"
    host_name "MyString"
    browser "MyString"
    date_of_execution "2012-11-16"
    user_timezone "MyString"
  end
end
