# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_metadatum, :class => TestMetadatum do
    platform
    platform_version "1.0.199"
    ci_job_name "Build"
    os "MacOSX"
    test_execution_machine_name "host_pc"
    browser_or_device "firefox"
    environment "Dev"
    date_of_execution "2013-02-20 00:00:00"
    test_category "UNIT TEST"
    test_report_type "JUnit"
    test_sub_category "UNIT TEST"
    branch "master"
  end
end
