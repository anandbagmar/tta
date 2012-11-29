class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
    @comparative_analysis = ComparativeAnalysis.new

    @result_set1 = ComparativeAnalysis.getPercentageOfPassingTests
    p "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    p "++++++++++++++++++++++RESULT SET+++++++++++++++++++++++++++++++++++++++++"
    p @result_set1
    #@result_set2 = ComparativeAnalysis.getProjectData2
    #p @result_set1
    #p @result_set2

=begin
    @data = [ [
                 [1301634000000, 315.71], #Apr 1, 2011
                 [1302238800000, 209.21], #Apr 8, 2011
                 [1302843600000, 420.36], #Apr 15
                 [1303448400000, 189.86], #4/22
                 [1304053200000, 314.93], #4/29
                 [1304658000000, 279.71], #5/6
                 [1305262800000, 313.34], #5/13
                 [1305867600000, 114.67], #5/20
                 [1306472400000, 315.58] #5/27
             ] ];
=end

  end

  def show

  end

  def index

  end

  def date_filter
    start_date= params[:start_date]
    end_date= params[:end_date]
    p start_date
    p end_date
    render :create
  end

end