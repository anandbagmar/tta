class ComparativeAnalysisController < ApplicationController
  # To change this template use File | Settings | File Templates.
  def new
  end

  def create
    @comparative_analysis = ComparativeAnalysis.new
    render :action => 'create'

  end

  def show

  end

  def index

  end
end