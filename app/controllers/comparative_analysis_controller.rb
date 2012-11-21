class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
    @comparative_analysis = ComparativeAnalysis.new
    @result_set = ComparativeAnalysis.getProjectData params[:tests]
    p @result_set
  end

  def show

  end

  def index

  end


end