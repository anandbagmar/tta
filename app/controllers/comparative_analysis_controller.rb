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
    @start_date= params[:start_date]
    @end_date= params[:end_date]
    @result_set1 = ComparativeAnalysis.getPercentageOfPassingTests(1,@start_date,@end_date)
    @project1_name = ComparativeAnalysis.getProjectName(1)

    @result_set2=ComparativeAnalysis.getPercentageOfPassingTests(2,@start_date,@end_date)
    @project2_name = ComparativeAnalysis.getProjectName(2)

     render :create
  end

end