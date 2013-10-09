# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_metadatum, :class => TestMetadatum do
    association :sub_project_id, :factory => :sub_project, :strategy => :build
    ci_job_name "Build"
    os_name "MacOSX"
    host_name "host_pc"
    browser "firefox"
    type_of_environment "Dev"
    date_of_execution "2013-02-20 00:00:00"
    test_category "UNIT TEST"
    test_report_type "JUnit"
    test_sub_category "UNIT TEST"
  end
end
