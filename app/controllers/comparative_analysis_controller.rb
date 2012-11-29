class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
    @comparative_analysis = ComparativeAnalysis.new

    @result_set1 = ComparativeAnalysis.getPercentageOfPassingTests(1)
    p @result_set1
    @result_set2=ComparativeAnalysis.getPercentageOfPassingTests(2)
    p @result_set2
  end

  def show

  end

  def index

  end

  def date_filter
    @start_date= params[:start_date]
    @end_date= params[:end_date]
     render :create
  end

end