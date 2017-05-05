class ExecutionTrendsController < ApplicationController
  def new
  end

  def class_names
    return bad_request unless request.xhr?
    @class_names=ExecutionTrends.new.get_class_names(params["platform_id"], params["test_category"], params["start_date"].to_date.beginning_of_day, params["end_date"].to_date.end_of_day)
    render json: @class_names
  end

  def show
    @start_date = params["start_date"]
    @end_date = params["end_date"]
    @result_set,@max_value = ExecutionTrends.new.get_result_set(params["platforms"],params["test_class_name"],@start_date,@end_date)
  end

end
