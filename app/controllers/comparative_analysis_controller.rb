class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
  end

  def show

  end

  def index

  end

  def date_filter
    @start_date= params[:comparative_analysis][:start_date]
    @end_date= params[:comparative_analysis][:end_date]
    project=Project.find(params[:project][:id])
    sub_projects_list = project.sub_projects

    @result_set = Hash.new
    sub_projects_list.each{ |sub_project|
      aggregate_value = ComparativeAnalysis.getPercentageOfPassingTests(sub_project.id, @start_date, @end_date)
      sub_project_name = sub_project.name
      @result_set[sub_project_name] = aggregate_value
    }

    render :create
  end

end