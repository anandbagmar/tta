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
    flash[:no_id_error]=nil
    flash[:no_date_error]=nil
    error_flag=0;
    sub_project_id=params[:sub_project][:id]
    analysis_date=params[:defect_analysis][:analysis_date]
    if sub_project_id.blank?
      flash[:no_id_error] = "No Sub-Project Selected"
      error_flag=1
    end
    if analysis_date==""
      flash[:no_date_error]="No Date Selected"
      error_flag=1
    end
    if error_flag ==1
      render 'defect_analysis/new'
    else
      @defect_analysis_json = DefectAnalysis.getResultJson(sub_project_id,analysis_date)
      render :create
    end
  end
end
