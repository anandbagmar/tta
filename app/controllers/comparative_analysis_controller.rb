class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
    @comparative_analysis = ComparativeAnalysis.new

    @result_set1 = ComparativeAnalysis.getProjectData1
    @result_set2 = ComparativeAnalysis.getProjectData2
    p @result_set1
    p @result_set2
  end

  def show

  end

  def index

  end


end