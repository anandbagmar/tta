class DefectAnalysisController < ApplicationController

  def new
    @projects=Project.select("id,name")
    @projects=@projects.to_json
    @projects
  end

  respond_to :json, :html

  def getRunDates

    @runDates=[]
    sub_project_id =params["subproject_id"]
    test_category =params["test_category"]
    if (test_category == "ALL")
      metadataForSelectedFilters = TestMetadatum.where(:sub_project_id => sub_project_id).select([:date_of_execution]).uniq
    else
      metadataForSelectedFilters = TestMetadatum.where(:sub_project_id => sub_project_id, :test_category => test_category).select([:date_of_execution]).uniq
    end
    metadataForSelectedFilters.each do |metadata|
      @runDates.append(metadata.date_of_execution)
    end
    respond_with(@runDates.to_json)
  end

  respond_to :json, :html

  def getSpecificRun
    sub_project_id =params["subproject_id"]
    test_category =params["test_category"]
    runDate =params["run_date"].to_date.to_s
    @specificRun = TestMetadatum.where("sub_project_id = ? AND test_category = ? AND date_of_execution LIKE ?", sub_project_id, test_category, "#{runDate}%")
    respond_with(@specificRun.to_json)
  end

  respond_to :json, :html

  def sub_project_filter
    sub_project_id=params["sub_projects"]
    analysis_date = params["dates"]
    if (!(params["test_runs"].nil?))
      analysis_date=params["dates"] + " " + params["test_runs"]
    end
    test_category =params["test_category"]
    @defect_analysis_json = DefectAnalysis.new.get_result_json(sub_project_id, analysis_date, test_category)
  end

end
