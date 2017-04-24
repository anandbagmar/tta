require "zip"
require 'nokogiri'
require 'fileutils'

class UploadController < ApplicationController
  def create
    project, sub_project, meta_data = parse_and_store_test_run_data
    redirect_to :action => :show, :project_id => project.id, :sub_project_id => sub_project.id, :project_meta_id => meta_data.id
  end

  def automatic
    time=Time.now.to_s
    date ={
        "year" => DateTime.parse(time).strftime("%Y"),
        "month" => DateTime.parse(time).strftime("%m"),
        "day" => DateTime.parse(time).strftime("%d"),
        "hour" => DateTime.parse(time).strftime("%H"),
        "minute" => DateTime.parse(time).strftime("%M")
    }
    params[:date] = date
    create
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

  def new
  end

  def get_test_sub_category
    @sub_category = TestCategoryMapping.new.get_sub_category(params["test_category"])
    render json: @sub_category
  end

  def get_default_test_sub_category
    @test_sub_category = TestCategoryMapping.where(:test_category => params["test_category"]).select("test_sub_category").first
    render json: @test_sub_category
  end

  private
  def parse_and_store_test_run_data
    project = Project.find_or_create_by_name((params[:project_name].split.join(" ").upcase))
    sub_project = project.add_sub_project(params)
    meta_data=sub_project.create_test_metadatum params
    sub_project.parse_and_save_log_files(meta_data, params)
    return project, sub_project, meta_data
  end
end



