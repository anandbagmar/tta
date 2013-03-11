

class ComparativeAnalysis


  def get_result_set(project_id, start_date, end_date)
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

  def get_percentage_of_passing_tests(sub_project_id, st_date,en_date)
    meta_data = SubProject.find(sub_project_id).test_metadatum.order("date_of_execution").find_all_by_date_of_execution(st_date.beginning_of_day..en_date.end_of_day)
    final_result = meta_data.inject([]){ |result, metadata_record|

      test_report_type = metadata_record.test_report_type
      nunit_flag = (test_report_type=="Unit NUnit"||test_report_type =="Groovy NUnit") ? 1 : 0
      number_of_failures, total_num_of_tests = (nunit_flag == 1 ? NunitParser.get_total_test_n_total_failure(metadata_record) : XmlParser.new.get_total_test_n_total_failure(metadata_record))

      result << [(metadata_record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f  * 100]
    }
    return final_result
  end
end