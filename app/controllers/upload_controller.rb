require 'xmlsimple'
require 'ftools'
require 'zip/zipfilesystem'

class UploadController < ApplicationController
  def create
    meta_datum, project, sub_project = create_or_update_meta_datum_and_dependency
    if meta_datum.save
      download_and_parse(meta_datum)
      redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_datum.id
    else
      flash[:project_error] = project.errors.messages
      flash[:sub_project_error] = sub_project.errors.messages
      flash[:meta_data_error] = meta_datum.errors.messages
      render 'upload/upload'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @sub_project= @project.sub_projects.find(params[:sub_project_id])
    @project_meta = @sub_project.test_metadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        flash[:notice] = "Project Successfully Saved!!"
        format.html
        format.json { render json: @project }
      end
    end
  end

  private
  def create_or_update_meta_datum_and_dependency
    project = Project.find_or_create_by_name(params[:project_name].upcase)
    sub_project = project.sub_projects.find_or_create_by_name(params[:sub_project_name].upcase)
    meta_datum = sub_project.test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type(params[:ci_job_name].upcase,
    meta_datum.date_of_execution= params[:test_metadatum][:date_of_execution]
    return meta_datum, project, sub_project
  end

  def download_and_parse(meta_datum)
    p params[:logDirectory].class
    p params[:logDirectory]
    tmp = params[:logDirectory].tempfile
    dir_path = "/home/tta/Desktop/"+params[:project_name]+Time.now.strftime("%d-%m-%y:%I:%M:%S")
    Dir.mkdir(dir_path,0777)
    file = File.join(dir_path, params[:logDirectory].original_filename)
    FileUtils.cp tmp.path, file
    Zip::ZipFile.open(file) do |zipFile|
      zipFile.each do |entry|
        contents = zipFile.read(entry)
        parse_xml(contents, meta_datum.id)
      end
    end
  end

  def parse_xml(config_xml, meta_id)
    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})
    @xml_data = TestSuiteRecord.new()
    @xml_data.test_metadatum_id=meta_id
    @xml_data.class_name= config['name']
    @xml_data.number_of_errors= config['errors']
    @xml_data.number_of_failures= config['failures']
    @xml_data.number_of_tests= config['tests']
    @xml_data.time_taken= config['time']
    @xml_data.save

  end

end
