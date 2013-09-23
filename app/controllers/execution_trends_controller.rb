class ExecutionTrendsController < ApplicationController
  def new
    @projects=Project.select("id,name").to_json
  end

  respond_to :json, :html

  def class_names
    @class_names=ExecutionTrends.new.get_class_names(params["subproject_id"],params["test_category"],params["start_date"].to_date.beginning_of_day,params["end_date"].to_date.end_of_day)
    respond_with(@class_names.to_json)
  end

  respond_to :json, :html

  def show
    @start_date = params["start_date"]
    @end_date = params["end_date"]
    @result_set = ExecutionTrends.new.get_result_set(params["test_class_name"])
  end

end
