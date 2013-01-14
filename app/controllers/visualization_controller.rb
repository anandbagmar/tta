class VisualizationController < ApplicationController

  def pyramid
  end

  def sub_project_filter
      sub_project_id=params[:sub_project][:id]
      if sub_project_id.blank?
        flash[:no_id_error] = "No Sub-Project Selected"
        flash[:no_test_error]=nil
        render 'visualization/pyramid'
     else
      @json = Visualization.getResultJson(sub_project_id)
      flash[:no_id_error]=""
      render :pyramid
      end
  end
end
