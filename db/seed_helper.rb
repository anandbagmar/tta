require_relative 'common_seed_data'
module Seed
  module Helper
    def self.create_seed_data(number_of_products, number_of_platforms_per_product, number_of_test_metadatum_per_platform, number_of_test_suite_records_per_test_metadatum, number_of_test_case_records_per_test_suite_record)
      puts "Seeding data in DB with:"
      puts "\tnumber_of_products                                : #{number_of_products}"
      puts "\tnumber_of_platforms_per_product                   : #{number_of_platforms_per_product}"
      puts "\tnumber_of_test_metadatum_per_platform             : #{number_of_test_metadatum_per_platform}"
      puts "\tnumber_of_test_suite_records_per_test_metadatum   : #{number_of_test_suite_records_per_test_metadatum}"
      puts "\tnumber_of_test_case_records_per_test_suite_record : #{number_of_test_case_records_per_test_suite_record}"
      puts "\tnumber_of_test_step_records_per_test_suite_record : #{number_of_test_case_records_per_test_suite_record}"

      (1..number_of_products).each do |product_number|
        product_id = create_product(product_number)
        (1..number_of_platforms_per_product).each do |platform_number|
          platform_id = create_platform(product_id, platform_number)
          (1..number_of_test_metadatum_per_platform).each do |test_meta_data_number|
            test_meta_data_id = create_test_meta_data(platform_id, test_meta_data_number)
            (1..number_of_test_suite_records_per_test_metadatum).each do |test_suite_record_number|
              test_suite_record_id = create_test_suite_record(test_meta_data_id, product_id, platform_id, test_suite_record_number)
              (1..number_of_test_case_records_per_test_suite_record).each do |test_case_record_number|
                test_case_record_id = create_test_case_record(test_suite_record_id, product_id, platform_id, test_case_record_number)
                (1..number_of_test_case_records_per_test_suite_record).each do |test_step_record_number|
                  create_test_step_record(test_case_record_id, product_id, platform_id, test_step_record_number)
                end
              end
            end
          end
        end
      end
    end

    def self.create_test_meta_data(platform_id, test_meta_data_number)
      puts "Creating Test Metadata - Platform: #{platform_id}, Number: #{test_meta_data_number}"
      test_category             = SAMPLE_TEST_CATEGORIES[rand(SAMPLE_TEST_CATEGORIES.length)]
      test_sub_category         = get_respective_test_sub_category(test_category)
      random_time               = (DateTime.now - (test_meta_data_number + test_meta_data_number%10.to_f)).to_time
      test_meta_data            = TestMetadatum.create(
          :platform_id                 => platform_id,
          :ci_job_name                 => SAMPLE_CI_JOB_NAMES[rand(SAMPLE_CI_JOB_NAMES.length)],
          :ci_build_number             => "#{test_meta_data_number}",
          :platform_version            => "v1.0.399",
          :os                          => SAMPLE_OS_TYPES[rand(SAMPLE_OS_TYPES.length)],
          :branch                      => SAMPLE_BRANCH_NAMES[rand(SAMPLE_BRANCH_NAMES.length)],
          :test_execution_machine_name => SAMPLE_TEST_EXECUTION_MACHINE_NAMES[rand(SAMPLE_TEST_EXECUTION_MACHINE_NAMES.length)],
          :browser_or_device           => SAMPLE_BROWSER_OR_DEVICE_TYPES[rand(SAMPLE_BROWSER_OR_DEVICE_TYPES.length)],
          :environment                 => SAMPLE_TEST_ENVIRONMENTS[rand(SAMPLE_TEST_ENVIRONMENTS.length)],
          :date_of_execution           => random_time,
          :test_category               => test_category,
          :test_sub_category           => test_sub_category,
          :test_report_type            => SAMPLE_TEST_REPORT_TYPES[rand(SAMPLE_TEST_REPORT_TYPES.length)])
      test_meta_data.platform_id= platform_id
      test_meta_data.save
      TestMetadatum.where(:platform_id => platform_id).last.id
    end

    def self.get_respective_test_sub_category(test_category)
      SAMPLE_TEST_SUB_CATEGORY[test_category][rand(SAMPLE_TEST_SUB_CATEGORY[test_category].length)]
    end

    def self.create_product(product_number)
      puts "Creating Product - #{product_number}"
      product_name = "PRODUCT #{product_number}"
      product      = Product.create(:name => product_name)
      product.save
      Product.find_by_name(product_name).id
    end

    def self.create_platform(product_id, platform_number)
      platform_name = "Platform #{product_id}.#{platform_number}"
      puts "Creating Platform - #{platform_name}"
      platform           = Platform.create(:name => platform_name)
      platform.product_id= product_id
      platform.save
      Platform.find_by_name(platform_name).id
    end

    def self.create_test_suite_record(test_meta_data_id, product_id, platform_id, test_suite_record_number)
      test_suite_record_name = "Class #{product_id}.#{platform_id}.#{test_meta_data_id}.#{test_suite_record_number}"
      puts "Creating Test Suite - #{test_suite_record_name}"
      test_suite_record = TestSuiteRecord.create_and_save(:test_metadatum_id => test_meta_data_id, :class_name => test_suite_record_name, :number_of_tests => rand(25..50), :number_of_errors => rand(12), :number_of_failures => rand(12), :time_taken => rand(1..5).to_s)
      test_suite_record.id
    end

    def self.create_test_case_record(test_suite_record_id, product_id, platform_id, test_case_record_number)
      test_case_record_name = "Class #{product_id}.#{platform_id}.#{test_suite_record_id}.#{test_case_record_number}"
      puts "Creating Test Case - #{test_case_record_name}"
      test_case_record                     = TestCaseRecord.create(:class_name => test_case_record_name, :time_taken => rand(1..4).to_s, :error_msg => "Error Message for Class - #{product_id}.#{platform_id}.#{test_suite_record_id}.#{test_case_record_number}")
      test_case_record.test_suite_record_id= test_suite_record_id
      test_case_record.save
      test_case_record.id
    end

    def self.create_test_step_record(test_case_record_id, product_id, platform_id, test_step_record_number)
      test_step_record_name = "Step #{product_id}.#{platform_id}.#{test_case_record_id}.#{test_step_record_number}"
      puts "Creating Test Step - #{test_step_record_name}"
      test_step_record_to_be_created = { :test_case_record_id => test_case_record_id,
                                         :step_name           => test_step_record_name,
                                         :status              => SAMPLE_TEST_STATUS[test_step_record_number % SAMPLE_TEST_STATUS.length],
                                         :time_taken          => test_step_record_number % SAMPLE_TEST_STATUS.length
      }
      if test_step_record_to_be_created[:status] == "failed"
        test_step_record_to_be_created[:error_msg] = "Error Message for Step - #{product_id}.#{platform_id}.#{test_case_record_id}.#{test_step_record_number}"
      end
      test_step_record = TestStepRecord.create_and_save(test_step_record_to_be_created)
    end
  end
end

