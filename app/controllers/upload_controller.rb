class UploadController < ApplicationController
  def new
    #@project = Project.new()
    #@project_meta_datum = ProjectMetaDatum.new(params[:ProjectMetaDatum])
    #@project_meta_datum = Project_meta_datum.new(params[:project_meta_datum])
  end
  def create
    @project_meta = ProjectMetadatum.new()
   if @project = Project.find_by_name(params[:name])
      @project_meta.project=@project
   else

    @project = Project.new()

    @project_meta.project = @project
    @project.name = params[:name]
    @project.type_of_report = params[:type_of_report]

    end

    @project_meta.sub_project_name= params[:sub_project_name]
    @project_meta.os_name= params[:os_name]
    @project_meta.host_name= params[:host_name]
    @project_meta.browser= params[:browser]
    @project_meta.type_of_enviornment=params[:type_of_enviornment]
    @project_meta.date_of_execution= params[:date_of_execution]
    @project.save!
    @project_meta.save!



    #code to upload file
    tmp = params[:myFile].tempfile

    require 'ftools'
    file = File.join("public", params[:myFile].original_filename)
    FileUtils.cp tmp.path, file


  redirect_to :action => :show , :project_id => @project.id , :project_meta_id => @project_meta.id

    require 'zip/zipfilesystem'

    Zip::ZipFile.open(file) do |zipfile|
      zipfile.each do |entry|
           puts zipfile.read(entry)

      end
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @project_meta = ProjectMetadatum.find(params[:project_meta_id])


    #@project = Project.first
    #render "show" ,:locals => { :project => @project}
    begin
        respond_to do |format|
          format.html #show.html.erb
          format.json { render json: @project }
        end
    end
  end


end
