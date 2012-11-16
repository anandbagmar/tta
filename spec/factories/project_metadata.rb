# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_metadatum, :class => 'ProjectMetadata' do
    project_id 1
    os_name "MyString"
    host_name "MyString"
    browser "MyString"
    date_of_execution "2012-11-16"
    user_timezone "MyString"
  end
end
