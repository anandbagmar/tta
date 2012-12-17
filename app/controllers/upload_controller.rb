require 'xmlsimple'
require 'ftools'
require 'net/scp'

class UploadController < ApplicationController


  def create
    project = Project.find_or_create_by_name(params[:project_name])
    sub_project = project.sub_projects.find_or_create_by_name(params[:sub_project_name])

    meta_datum = sub_project.test_metadatum.find_or_create_by_ci_job_name_and_browser_and_type_of_environment_and_host_name_and_os_name_and_test_category_and_test_report_type(params[:ci_job_name],
                  params[:browser],params[:type_of_environment],params[:host_name],params[:os_name],params[:test_category],params[:test_report_type])

    meta_datum.date_of_execution= params[:test_metadatum][:date_of_execution]

    meta_datum.save!

    path = Dir.glob(params[:logDirectory]+"/**/"+params[:filePattern])

    #All files are copied in the same folder "tta"
    #For adding files to a new folder , create the folder and change the path here
    Net::SCP::start("10.12.6.142","tta", :password => "ttas") do |scp|
      path.each do |files|
        scp.upload!(files, "/home/tta/tta/")
        parse_xml(files,meta_datum.id)
      end
    end

    redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_datum.id
  end

  def show
    @project = Project.find(params[:project_id])
    @sub_project= @project.sub_projects.find(params[:sub_project_id])
    @project_meta = @sub_project.test_metadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        format.html
        format.json { render json: @project }
      end
    end
  end

  def parse_xml(config_xml, meta_id)
    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})
    @xml_data = TestRecord.new()
    @xml_data.test_metadatum_id=meta_id
    @xml_data.class_name= config['name']
    @xml_data.number_of_errors= config['errors']
    @xml_data.number_of_failures= config['failures']
    @xml_data.number_of_tests= config['tests']
    @xml_data.time_taken= config['time']
    @xml_data.save

  end

end
