class DefectAnalysisController < ApplicationController
  def new
  end

  def create
  end

  def show

  end

  def index

  end
  def sub_project_filter
    sub_project_id=params[:sub_project][:id]
    analysis_date=params[:comparative_analysis][:analysis_date]
    @defect_analysis_json = DefectAnalysis.getResultJson(sub_project_id,analysis_date)
    render :create
  end

end
