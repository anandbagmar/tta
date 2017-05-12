require 'json'

class CucumberJSONParser
  def self.parse(meta_id, extracted_json)
    # puts "CucumberJSONParser: parse: meta_id: #{meta_id}"
    @parsed_json = JSON.parse(extracted_json)
    save_test_suites(meta_id, @parsed_json)
  end

  def self.save_test_suites(meta_id, extracted_json)
    extracted_json.each_with_index { |eachSuite, suiteIndex|
      save_test_suite(eachSuite, meta_id)
    }
  end

  def self.save_test_suite(each_suite, meta_id)
    test_suite_record_to_be_created = { :time_taken              => 0,
                                        :test_metadatum_id       => meta_id,
                                        :class_name              => each_suite["name"],
                                        :number_of_tests         => each_suite["elements"].length,
                                        :number_of_errors        => 0,
                                        :number_of_failures      => 0,
                                        :number_of_tests_not_run => 0,
                                        :number_of_tests_ignored => 0
    }
    saved_test_suite_data           = TestSuiteRecord.create_and_save(test_suite_record_to_be_created)

    save_test_case_records(each_suite, saved_test_suite_data, test_suite_record_to_be_created)
  end

  def self.save_test_case_records(each_suite, saved_test_suite_data, test_suite_record_to_be_created)
    backgroundSteps = []
    each_suite["elements"].each_with_index { |each_test_case, testCaseIndex|
      if each_test_case["type"] == "background"
        backgroundSteps = each_test_case["steps"]
      else
        test_suite_record_to_be_created = save_test_case_record(each_test_case, backgroundSteps, saved_test_suite_data, test_suite_record_to_be_created)
        saved_test_suite_data.update! test_suite_record_to_be_created
      end
    }
  end

  def self.save_test_case_record(each_test_case, backgroundSteps, saved_test_suite_data, test_suite_record_to_be_created)
    test_case_record_to_be_created = { :test_suite_record_id => saved_test_suite_data.id,
                                       :class_name           => each_test_case["name"],
                                       :time_taken           => 0,
                                       :error_msg            => "",
                                       :status               => "n/a"
    }
    saved_test_case_record_data    = TestCaseRecord.create_and_save(test_case_record_to_be_created)

    if each_test_case["type"] == "scenario"
      step_name                                                       = "Before - " + each_test_case["before"][0]["match"]["location"]
      test_suite_record_to_be_created, test_case_record_to_be_created = save_test_step_record(test_suite_record_to_be_created, test_case_record_to_be_created, saved_test_case_record_data, each_test_case["before"][0], step_name)

      saved_test_case_record_data.update! test_case_record_to_be_created

      backgroundSteps.each_with_index { |eachStep, stepIndex|
        stepName                                                        = eachStep["name"]
        # test_case_record_to_be_created[:class_name] = stepName
        test_suite_record_to_be_created, test_case_record_to_be_created = save_test_step_record(test_suite_record_to_be_created, test_case_record_to_be_created, saved_test_case_record_data, eachStep, stepName)
        saved_test_case_record_data.update! test_case_record_to_be_created
      }

      each_test_case["steps"].each_with_index { |eachStep, stepIndex|
        stepName                                                        = eachStep["name"]
        test_suite_record_to_be_created, test_case_record_to_be_created = save_test_step_record(test_suite_record_to_be_created, test_case_record_to_be_created, saved_test_case_record_data, eachStep, stepName)
        saved_test_case_record_data.update! test_case_record_to_be_created
      }

      step_name                                                       = "After - " + each_test_case["after"][0]["match"]["location"]
      test_suite_record_to_be_created, test_case_record_to_be_created = save_test_step_record(test_suite_record_to_be_created, test_case_record_to_be_created, saved_test_case_record_data, each_test_case["after"][0], step_name)
      saved_test_case_record_data.update! test_case_record_to_be_created
    end

    if test_case_record_to_be_created[:status] == "failed"
      test_suite_record_to_be_created[:number_of_failures]+=1
    elsif test_case_record_to_be_created[:status] == "ignored"
      test_suite_record_to_be_created[:number_of_tests_ignored]+=1
    elsif test_case_record_to_be_created[:status] == "skipped"
      test_suite_record_to_be_created[:number_of_tests_not_run]+=1
    end

    test_suite_record_to_be_created[:time_taken] += test_case_record_to_be_created[:time_taken]
    return test_suite_record_to_be_created
  end

  def self.save_test_step_record(test_suite_record_to_be_created, test_case_record_to_be_created, saved_test_case_record_data, eachStep, step_name)
    test_step_record_to_be_created              = { :test_case_record_id => saved_test_case_record_data.id,
                                                    :step_name           => step_name,
                                                    :status              => eachStep["result"]["status"]
    }
    test_step_record_to_be_created[:time_taken] = eachStep["result"]["duration"].nil? ? 0 : eachStep["result"]["duration"]/1000000000
    test_case_record_to_be_created[:time_taken] += test_step_record_to_be_created[:time_taken]

    if !eachStep["result"]["error_message"].nil?
      test_step_record_to_be_created[:error_msg] = eachStep["result"]["error_message"]
      test_case_record_to_be_created[:error_msg] = eachStep["result"]["error_message"]
    end

    if test_case_record_to_be_created[:status] != "failed"
      test_case_record_to_be_created[:status] = test_step_record_to_be_created[:status]
    end

    saved_test_step_record = TestStepRecord.create_and_save(test_step_record_to_be_created)
    return test_suite_record_to_be_created, test_case_record_to_be_created
  end
end
