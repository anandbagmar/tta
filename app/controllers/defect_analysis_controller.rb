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
    sub_project_name = SubProject.find(sub_project_id, :select => "name").name
    analysis_date=params[:defect_analysis][:analysis_date]

    @defect_analysis_json = DefectAnalysis.new.get_result_json(sub_project_id, analysis_date.to_date)
    parsed_json = ActiveSupport::JSON.decode(@defect_analysis_json)

    if parsed_json["errors"].blank?
      flash[:no_errors]="No build runs on "+ analysis_date +" for Sub Project "+sub_project_name
    elsif !(parsed_json["errors"].nil?) then
      if parsed_json["errors"].values[0][0].blank?
        flash[:no_errors]="No failing tests for the latest build run on "+ analysis_date +" for Sub Project "+sub_project_name
      end
    end
    render :create
  end
end
