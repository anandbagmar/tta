# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_metadatum, :class => 'TestMetadatum' do
    ci_job_name "Build"
    os_name "MacOSX"
    host_name "host_pc"
    browser "firefox"
    type_of_environment "Dev"
    date_of_execution "2012-11-16"
    test_category "Unit Test"
    test_report_type "JUnit"
  end
end
