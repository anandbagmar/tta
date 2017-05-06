puts "Loaded tta.rake"

namespace :tta do

  $product_name=""
  $platform_name=""
  $ci_job_name=""
  $test_category=""
  $test_sub_category=""
  $test_report_type=""
  $os=""
  $test_execution_machine_name=""
  $browser_or_device=""
  $environment=""
  $date=""
  $log_directory=""
  $file_pattern=""
  $commit=""
  $file_uploaded=""

  desc "Run unit_tests"
  task :unit_tests => ['db:drop', 'db:create', 'db:migrate', 'spec']

  desc "Upload all artifacts"
  task :upload_artifacts, [:test_type,:test_sub_category, :file_path, :test_report_type] do |t, args|
    Rake::Task['tta:upload_to_tta'].invoke("TTA", "TTA_sub", "Build", args.test_type, args.test_sub_category ,args.test_report_type, "Ubuntu", "host-pc", "none", "Dev", "", args.file_path, "*.xml")
  end
  task :create_cucumber_zip do
    `zip cucumber_results.zip log/tta_cukes_result/*.xml`
  end
  task :create_zip do
    `zip tta_spec_results.zip log/tta_spec_results.xml`
  end

  task :upload_to_tta, [:product_name, :platform_name, :ci_job_name, :test_category, :test_sub_category, :test_report_type, :os, :test_execution_machine_name, :browser_or_device, :environment, :date_of_execution, :logDirectory, :filePattern, :commit] do |t, args|
    args.with_defaults(:product_name => "demoProduct", :platform_name => "demoPlatform", :ci_job_name => "demoCIJob", :test_category => "Unit Test",:test_sub_category => "UNIT TEST", :test_report_type => "Junit", :os => "MAc", :test_execution_machine_name => "xyz", :browser_or_device => "Chrome", :environment => "Dev", :date_of_execution => "1900-12-12", :logDirectory => "asd", :filePattern => "*.xml", :commit => "SUBMIT")
    $product_name = args.product_name
    $platform_name = args.platform_name
    $ci_job_name = args.ci_job_name
    $test_category=args.test_category
    $test_sub_category=args.test_sub_category
    $test_report_type=args.test_report_type
    $os=RUBY_PLATFORM
    $test_execution_machine_name=`hostname`.strip
    $browser_or_device=args.browser_or_device
    $environment=args.environment
    $log_directory=args.logDirectory
    $file_pattern=args.filePattern
    $commit=args.commit
    `curl -F 'authenticity_token=KBc5IruWAILeOOIVKoqozwSYx3eSatES/fklIGf/Cn4=' -F 'product_name=#{$product_name}' -F 'platform_name=#{$platform_name}' -F 'ci_job_name=#{$ci_job_name}' -F 'test_category=#{$test_category}' -F 'test_sub_category=#{$test_sub_category}' -F 'test_report_type=#{$test_report_type}' -F 'os=#{$os}' -F 'test_execution_machine_name=#{$test_execution_machine_name}' -F 'browser_or_device=#{$browser_or_device}' -F 'environment=#{$environment}' -F 'date="" ' -F 'logDirectory=@#{$log_directory}' -F 'commit=SUBMIT' 'tta.thoughtworks.com:3000/upload/automatic'`
  end
end