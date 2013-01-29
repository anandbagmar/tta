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


  private

  def create_test_metadatum params
    meta_datum = test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type_and_date_of_execution(params[:ci_job_name].upcase,
    params[:browser].upcase, params[:type_of_environment].upcase, params[:host_name].upcase, params[:os_name].upcase, params[:test_category].upcase, params[:test_report_type].upcase,params[:date_of_execution])
    meta_datum.save
    return meta_datum
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
