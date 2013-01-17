require 'ftools'
require 'zip/zipfilesystem'
require 'nokogiri'
require 'fileutils'

class UploadController < ApplicationController
  def create
    project,sub_project,meta_data = create_project_with_dependency
    redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_data.id
  end

  def show
    @project = Project.find(params[:project_id])
    @sub_project= @project.sub_projects.find(params[:sub_project_id])
    @project_meta = @sub_project.test_metadatum.find(params[:project_meta_id])
    begin
      respond_to do |format|
        flash[:notice] = "Project Successfully Saved!!"
        format.html
        format.json { render :json => @project }
      end
    end
  end

  private
  def create_project_with_dependency
    project = Project.find_or_create_by_name(params[:project_name].upcase)
    sub_project,meta_data = project.add_sub_project(params)
    return project,sub_project,meta_data
  end


  def create_directory_structure
    FileUtils.mkdir_p(Dir.home+"/Documents/"+params[:project_name]+"/"+params[:sub_project_name]+"/"+Time.now.strftime("%d-%m-%y-%I:%M:%S")).first
  end

end



