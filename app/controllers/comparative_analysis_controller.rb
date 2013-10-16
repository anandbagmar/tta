class ComparativeAnalysisController < ApplicationController

  def create
  end

  def date_filter
    @start_date= params[:comparative_analysis][:start_date]
    @end_date= params[:comparative_analysis][:end_date]
    @project_name = Project.find_by_id(params["project_id"]).name
    flash[:no_data_error]=nil
    @result_set = ComparativeAnalysis.new.get_result_set(params["project_id"], @start_date.to_date, @end_date.to_date)
    if !(@result_set.nil?)
      if @result_set[@result_set.keys[0]].empty?
        flash[:no_data_error]="No Data between the Date Range "+@start_date+" To "+@end_date
      end
    end
    render :create
  end
end



