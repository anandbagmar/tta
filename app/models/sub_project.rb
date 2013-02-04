class SubProject < ActiveRecord::Base
  has_many :test_metadatum
  attr_accessible :name
  belongs_to :project
  validates :name, :presence => {:message => 'cannot be blank, Task not saved'}


  def create_dependency params
    test_metadatum = create_test_metadatum(params)
    save_log_files(test_metadatum, params)
    test_metadatum
  end


  def self.get_data_for_test_category(sub_project_id,test_type)
    meta_data = find(sub_project_id).test_metadatum.find_all_by_test_category(test_type)
    result = TestMetadatum.find_no_and_duration_of_test(meta_data)
    result
  end

  private

  def create_test_metadatum params
    date_of_execution = get_date_and_timestamp(params[:date])
    meta_datum = test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type_and_date_of_execution(params[:ci_job_name].upcase,
    params[:browser].upcase, params[:type_of_environment].upcase, params[:host_name].upcase, params[:os_name].upcase, params[:test_category].upcase, params[:test_report_type].upcase,date_of_execution)
    meta_datum.save
    return meta_datum
  end

  def get_date_and_timestamp(date_input)
    date_object = DateTime.strptime(date_input[:day]+' '+date_input[:month]+' '+date_input[:year]+' '+date_input[:hour]+' '+date_input[:minute], '%d %m %Y %I %M ')
    date_of_execution = date_object.to_time.strftime("%Y-%m-%d %I:%M:%S")
    date_of_execution

  end

  def save_log_files(meta_datum,params)
    input_file_name = params[:logDirectory].original_filename
    output_file_path = File.join(log_dir, input_file_name)
    input_file_path = params[:logDirectory].path

    XmlParser.parse input_file_path, output_file_path, meta_datum.id,params

  end

  def log_dir
    FileUtils.mkdir_p(Dir.home+"/Documents/"+ project.name + "/"+ name + "/" +Time.now.strftime("%d-%m-%y-%I:%M:%S"))
  end

end
