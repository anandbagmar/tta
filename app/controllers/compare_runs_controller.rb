class CompareRunsController < ApplicationController

  def index
  end

  def getPlatforms
    product_id =params["product_id"]
    @platforms = Platform.where(:product_id => product_id).select([:id, :name])
    respond_with(@platforms.to_json)
  end

  respond_to :json, :html

  def getTestTypes
    platform_id =params["platform_id"]
    @test_types = TestMetadatum.where(:platform_id => platform_id).select([:test_category]).uniq
    respond_with(@test_types.to_json)
  end

  respond_to :json, :html

  def getDateRuns
    platform_id    =params["platform_id"]
    test_category  =params["test_category"]
    @compare_dates = TestMetadatum.where(:platform_id => platform_id, :test_category => test_category).select([:date_of_execution]).uniq
    respond_with(@compare_dates.to_json)
  end

  respond_to :json, :html

  def getCompareJson
    @compare_hash         = CompareRuns.getCompareResult(params)
    @compare_hash["dates"]=[params["date_one"], params["date_two"]]
    @compare_json         =@compare_hash.to_json
    @compare_json.gsub!('"', '\"')
  end
end
