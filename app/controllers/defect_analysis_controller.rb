class DefectAnalysisController < ApplicationController

  def new
  end

  def getRunDates
    platform_id =params["platform_id"]
    test_category =params["test_category"]
    metadataForSelectedFilters = TestMetadatum.where(:platform_id => platform_id).select([:id, :date_of_execution]).uniq(:date_of_execution)

    if (test_category != "ALL")
      metadataForSelectedFilters = metadataForSelectedFilters.where(:test_category => test_category)
    end
    @runDates= getValidMetadataRecords(metadataForSelectedFilters)
    respond_with(@runDates.to_json)
  end

  respond_to :json, :html

  def getSpecificRun
    platform_id =params["platform_id"]
    test_category =params["test_category"]
    runDate =params["run_date"].to_date.to_s
    metadataForSelectedFilters = TestMetadatum.where("platform_id = ? AND test_category = ? AND date_of_execution LIKE ?", platform_id, test_category, "#{runDate}%")
    @specificRun=getValidMetadataRecords(metadataForSelectedFilters)
    respond_with(@specificRun.to_json)
  end

  respond_to :json, :html

  def platform_filter
    platform_id=params["platforms"]
    @analysis_date = params["dates"]
    if (!(params["test_runs"].nil?))
      @analysis_date=params["dates"] + " " + params["test_runs"]
    end
    test_category =params["test_category"]
    @defect_analysis_json = DefectAnalysis.new.get_result_json(platform_id, @analysis_date, test_category)
  end

  def getValidMetadataRecords(metadataRecords)
    runs = []
    metadataRecords.each do |metadata|
      if (TestSuiteRecord.find_by_test_metadatum_id(TestMetadatum.where(:date_of_execution => metadata.date_of_execution))!=[])
        runs.append(metadata.date_of_execution)
      end
    end
    runs
  end

end
