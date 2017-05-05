require 'json'

class CucumberJSONParser
  def self.parse(meta_id, extracted_json)
    # puts "CucumberJSONParser: parse: meta_id: #{meta_id}, extracted_json: #{extracted_json}"
    puts "CucumberJSONParser: parse: meta_id: #{meta_id}"
    @parsed_json = JSON.parse(extracted_json)
    # test_suite_id=save_test_suite(meta_id)
    # save_test_case_record(test_suite_id)
    puts "@parsed_json - #{@parsed_json}"
  end
end
