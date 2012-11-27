require 'xmlsimple'
require 'zip/zipfilesystem'
require 'ftools'


class UploadController < ApplicationController


  def create
    @project_meta = ProjectMetadatum.new()
    if @project = Project.find_by_name(params[:name])
      @project_meta.project=@project
    else

      @project = Project.new()

      @project_meta.project = @project
      @project.name = params[:name].upcase
      @project.type_of_report = params[:type_of_report].upcase

    end

    @project_meta.sub_project_name= params[:sub_project_name].upcase
    @project_meta.os_name= params[:os_name].upcase
    @project_meta.host_name= params[:host_name].upcase
    @project_meta.browser= params[:browser].upcase
    @project_meta.type_of_enviornment=params[:type_of_enviornment].upcase
    @project_meta.date_of_execution= params[:date_of_execution]
    @project.save!
    @project_meta.save!

    #code to upload file
    tmp = params[:myFile].tempfile
    file = File.join("public", params[:myFile].original_filename)
    FileUtils.cp tmp.path, file
    Zip::ZipFile.open(file) do |zipfile|
        zipfile.each do |entry|
        p tempp=entry.to_s
        contents = zipfile.read(entry)
        contents_string= contents.to_s
        if tempp =~ /\.xml$/
          if contents_string.start_with? ("<?xml")
            parse_xml(contents, @project_meta.id)
          end
        end
      end
    end

    redirect_to :action => :show, :project_id => @project.id, :project_meta_id => @project_meta.id
  end

  def show
    @project = Project.find(params[:project_id])
    @project_meta = ProjectMetadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        format.html #show.html.erb
        format.json { render json: @project }
      end
    end
  end

  def parse_xml(config_xml, meta_id)
    config = XmlSimple.xml_in(config_xml, {'KeyAttr' => 'name'})
    @xml_data = TestRecord.new()
    @xml_data.project_metadatum_id=meta_id
    @xml_data.class_name= config['name']
    @xml_data.number_of_errors= config['errors']
    @xml_data.number_of_failures= config['failures']
    @xml_data.number_of_tests= config['tests']
    @xml_data.time_taken= config['time']
    @xml_data.save

  end

end
