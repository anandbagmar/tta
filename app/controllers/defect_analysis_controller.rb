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
    flash[:no_errors]=nil
    sub_project_id=params[:sub_project][:id]
    analysis_date=params[:defect_analysis][:analysis_date]
    @defect_analysis_json = DefectAnalysis.get_result_json(sub_project_id,analysis_date)
    parsed_json = ActiveSupport::JSON.decode(@defect_analysis_json)

    if parsed_json["errors"].nil?  then
      flash[:no_errors]="No built runs on "+ analysis_date +" for the selected Sub Project"
    elsif parsed_json["errors"].blank?
      flash[:no_errors]="No failing tests on "+ analysis_date +" for the selected Sub Project"
    end
    render :create

  end
end
