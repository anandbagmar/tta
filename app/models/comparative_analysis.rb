

class ComparativeAnalysis


  def self.get_result_set(project_id, start_date, end_date)
    project=Project.find(project_id)
    sub_projects_list = project.sub_projects
    result_set = Hash.new
    sub_projects_list.each{ |sub_project|
      aggregate_value = get_percentage_of_passing_tests(sub_project.id, start_date, end_date)
      sub_project_name = sub_project.name
      result_set[sub_project_name] = aggregate_value
    }
    return result_set

  end

  private

  def self.get_percentage_of_passing_tests(sub_project_id, start_date,end_date)

    meta_data = SubProject.find(sub_project_id).test_metadatum.find_all_by_date_of_execution(start_date..end_date)
    meta_data.inject([]){ |result, metadata_record|
      total_num_of_tests = 0
      number_of_failures = 0
      metadata_record.test_suite_records.each do |test_suite_record|
        total_num_of_tests += test_suite_record.number_of_tests.to_i
        number_of_failures += test_suite_record.number_of_failures.to_i
      end
      result << [(metadata_record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f  * 100]
    }
  end

end