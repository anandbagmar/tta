class SubProject < ActiveRecord::Base
  has_many :test_metadatum
  attr_accessible :name
  belongs_to :project
  validates :name, :presence => {:message => 'cannot be blank, Task not saved'}


  def self.get_data_for_test_category(sub_project_id, test_type)
    meta_data = find(sub_project_id).test_metadatum.find_all_by_test_category(test_type)
    result = TestMetadatum.new.find_no_and_duration_of_test(meta_data)
    result
  end

  def create_test_metadatum params
    date_of_execution = get_date_and_timestamp(params[:date])
    test_sub_category = params[:test_sub_category]
    if (test_sub_category=="")
      case params[:test_category].upcase
        when "UNIT TEST"
          params[:test_sub_category]="UNIT TEST"
        when "INTEGRATION TEST"
          params[:test_sub_category]="INTEGRATION TEST"
        when "FUNCTIONAL TEST"
          params[:test_sub_category]="REGRESSION TEST"
      end
    end
    meta_datum = test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type_and_test_sub_category_and_date_of_execution((params[:ci_job_name]).split.join(" ").upcase, (params[:browser]).split.join(" ").upcase, (params[:type_of_environment]).split.join(" ").upcase, (params[:host_name]).split.join(" ").upcase, (params[:os_name]).split.join(" ").upcase, params[:test_category].upcase, params[:test_report_type].upcase, params[:test_sub_category], date_of_execution)
    meta_datum.save
    return meta_datum
  end

  def parse_and_save_log_files(meta_datum, params)
    input_file_name = params[:logDirectory].original_filename
    output_file_path = File.join(log_dir, input_file_name)
    input_file_path = params[:logDirectory].path
    Parser.new.parse_test_log_files input_file_path, output_file_path, meta_datum.id, params[:test_report_type]
  end

  private

  def get_date_and_timestamp(date_input)
    date_object = DateTime.strptime(date_input[:day]+' '+date_input[:month]+' '+date_input[:year]+' '+date_input[:hour]+' '+date_input[:minute], '%d %m %Y %H %M ')
    date_of_execution = date_object.to_time.strftime("%Y-%m-%d %H:%M:%S")
    date_of_execution
  end


  def log_dir
    FileUtils.mkdir_p($PROJECT_ROOT+"/../PROJECT_LOGS/"+project.name+ "/"+ name + "/" +Time.now.strftime("%d-%m-%y-%H:%M:%S"))
  end

end
