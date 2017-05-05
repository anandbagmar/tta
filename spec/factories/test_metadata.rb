# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_metadatum, :class => TestMetadatum do
    platform
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

FactoryGirl.define do
  factory :test_metadatum_hash, :class => Hash do
    platform
    ci_job_name "Build"
    os_name "MacOSX"
    host_name "host_pc"
    browser "firefox"
    type_of_environment "Dev"
    # date_of_execution "2013-02-20 00:00:00"
    test_category "UNIT TEST"
    test_report_type "JUnit"
    test_sub_category "UNIT TEST"

    initialize_with {attributes}
  end
end
