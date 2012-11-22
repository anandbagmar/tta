class UploadController < ApplicationController
  def new
    #@project = Project.new()
    #@project_meta_datum = ProjectMetaDatum.new(params[:ProjectMetaDatum])
    #@project_meta_datum = Project_meta_datum.new(params[:project_meta_datum])
  end
  def create
    @project = Project.new()
    @project.name = params[:name]
    @project.type_of_report = params[:type_of_report]
    @project.authorization_level = params[:authorization_level]
    puts "*"*50
    puts @project.inspect

    @project.save
    respond_to do |format|
    format.html { redirect_to @project, notice: 'project was successfully created.' }
    end
  end

  end
