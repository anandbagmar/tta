class ComparativeAnalysisController < ApplicationController

  def create
  end

  def test_category_mapping_list
    sub_project=SubProject.find(params["sub_project_id"])
    start_date=params["comparative_analysis_start_date"].to_date
    end_date= params["comparative_analysis_end_date"].to_date
    category_list = sub_project.test_metadatum.select("distinct test_category,test_sub_category")
    category_list=category_list.where("date_of_execution BETWEEN ? AND ?", start_date.beginning_of_day, end_date.end_of_day)
    @test_category_mapping_list_sorted = category_list.group_by { |list| list["test_category"] }
    @test_category_mapping_list_sorted.each do |test_category|
      @test_category_mapping_list_sorted[test_category[0]] = test_category[1].map { |e| e["test_sub_category"] }
    end
    render json: @test_category_mapping_list_sorted
  end

  def date_filter
    @start_date= params[:comparative_analysis][:start_date]
    @end_date= params[:comparative_analysis][:end_date]
    @project_name = Project.find_by_id(params["project_id"]).name
    flash[:no_data_error]=nil
    @result_set = ComparativeAnalysis.new.get_result_set(params["sub_project_id"], params["testSubCategory"], @start_date.to_date, @end_date.to_date)
    if !(@result_set.nil?)
      if (@result_set=={} || @result_set[@result_set.keys[0]].empty?)
        flash[:no_data_error]="No Data between the Date Range "+@start_date+" To "+@end_date
      end
    end
    render :create
  end
end



