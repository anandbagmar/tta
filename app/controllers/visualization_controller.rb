class VisualizationController < ApplicationController

  def pyramid
  end

  def sub_project_filter
      sub_project_id=params[:sub_project][:id]
      if sub_project_id.blank?
        flash[:no_id_error] = "No Sub-Project Selected"
        flash[:no_test_error]=nil
     else
      @json = Visualization.getResultJson(sub_project_id)
      @json.to_json.html_safe
      flash[:no_id_error]=""
      end
  end
end
