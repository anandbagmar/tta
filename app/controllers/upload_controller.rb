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
    @project_meta.browser=params[:type_of_enviornment]
    @project_meta.date_of_execution= params[:date_of_execution]



    puts "*"*50
    puts @project.inspect
    puts @project_meta.inspect
    @project.save!
    @project_meta.save!
    respond_to do |format|
    format.html { redirect_to '/upload/show', notice: 'Project was successfully created.' }

    end

  end

  def show
    @project = Project.find_by_name(params[:name])

    respond_to do |format|
      format.html #show.html.erb
      format.json { render json: @project }
    end
  end
  end
