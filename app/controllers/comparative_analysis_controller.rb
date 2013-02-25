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
    flash[:no_data_error]=nil
    flash[:date_error]=nil
    if (@start_date=="" or @end_date=="" or params[:project][:id]=="")
      flash[:required_field] = "This Field is required."
      render :create
    else
      if (@start_date >= @end_date)
        flash[:date_error]="select end date greater than start date"
      else
        @result_set = ComparativeAnalysis.get_result_set(params[:project][:id], @start_date, @end_date)
        flash[:required_field]=""
      end
      if !(@result_set.nil?)
        if @result_set[@result_set.keys[0]].empty?
        flash[:no_data_error]="No Data between the Date Range "+@start_date+" To "+@end_date
        end
      end
      render :create
    end
  end

end



