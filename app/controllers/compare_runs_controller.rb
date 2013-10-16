class CompareRunsController < ApplicationController

  def index
  end

  def getSubProjects
    project_id=params["project_id"]
    @sub_projects = SubProject.where(:project_id => project_id).select([:id, :name])
    respond_with(@sub_projects.to_json)
  end

  respond_to :json, :html
  def getTestTypes
    sub_project_id =params["subproject_id"]
    @test_types = TestMetadatum.where(:sub_project_id => sub_project_id).select([:test_category]).uniq
    respond_with(@test_types.to_json)
  end

  respond_to :json, :html
  def getDateRuns
    sub_project_id =params["subproject_id"]
    test_category =params["test_category"]
    @compare_dates = TestMetadatum.where(:sub_project_id => sub_project_id, :test_category => test_category).select([:date_of_execution]).uniq
    respond_with(@compare_dates.to_json)
  end

  respond_to :json, :html
  def getCompareJson
    @compare_hash = CompareRuns.getCompareResult(params)
    @compare_hash["dates"]=[params["date_one"], params["date_two"]]
    @compare_json =@compare_hash.to_json
    @compare_json
  end
end
