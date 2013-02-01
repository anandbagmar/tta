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
    @project_name = Project.find_by_id(params[:project][:id]).name
    flash[:date_error]=nil
    flash[:no_data_error]=nil
    if(@start_date=="" or @end_date=="" or params[:project][:id]=="")
      flash[:required_field] = "This Field is required."
      render :create
    else
      if(@start_date >= @end_date)
        flash[:date_error]="select end date greater than start date"
      else
        @result_set = ComparativeAnalysis.get_result_set(params[:project][:id],@start_date,@end_date)
        flash[:required_field]=""
      end
      render :create
    end
  end

end