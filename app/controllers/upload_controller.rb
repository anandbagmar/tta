class UploadController < ApplicationController
  def new
    #@project = Project.new()
    #@project_meta_datum = ProjectMetaDatum.new(params[:ProjectMetaDatum])
    #@project_meta_datum = Project_meta_datum.new(params[:project_meta_datum])
  end
  def create
    @project = Project.new()
    @project_meta = ProjectMetadatum.new()
    @project_meta.project = @project
    @project.name = params[:name]
    @project.type_of_report = params[:type_of_report]
    @project.authorization_level = params[:authorization_level]

    @project_meta.sub_project_name= params[:sub_project_name]
    @project_meta.os_name= params[:os_name]
    @project_meta.host_name= params[:host_name]
    @project_meta.browser= params[:browser]
    @project_meta.date_of_execution= params[:date_of_execution]
    @project_meta.user_timezone= params[:user_timezone]


    puts "*"*50
    puts @project.inspect
    puts @project_meta.inspect
    @project.save!
    @project_meta.save!
    respond_to do |format|
    format.html { redirect_to @project, notice: 'project was successfully created.' }

    end

  end

  end
