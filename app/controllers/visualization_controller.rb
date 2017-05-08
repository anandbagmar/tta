class VisualizationController < ApplicationController
  def pyramid
    begin
      respond_to do |format|
        format.html
        format.json { render :json => @json }
      end
    end
  end

  def platform_filter
    error                =""
    flash[:no_test_error]=nil
    platform_id          =params[:platform][:id]
    @json                = Visualization.new.getResultJson(platform_id)
    json_obj             = JSON.parse(@json)
    json_obj["test_types"].each do |test_type|
      if test_type["no_of_test"]==0
        error = error + " | "+test_type["test_name"] + " | "
      end
    end
    if (error!="")
      flash[:no_test_error]= "No Test data for your product for test category => " + error
    end
  end
end



