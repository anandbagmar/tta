class Platform < ActiveRecord::Base
  has_many :test_metadatum
  attr_accessible :name
  belongs_to :product
  before_validation :uppercase_name
  validates :name, :product_id, :presence => { :message => 'cannot be blank, Task not saved' }
  validates_uniqueness_of :name, scope: [:product_id], :case_sensitive => false

  def self.get_platform_name(platform_id)
    Platform.find_by_id(platform_id).name
  end

  def self.get_data_for_test_category(platform_id, test_type)
    meta_data = find(platform_id).test_metadatum.find_all_by_test_category(test_type)
    result    = TestMetadatum.new.find_no_and_duration_of_test(meta_data)
    result
  end

  def create_test_metadatum params
    date_of_execution = get_date_and_timestamp(params[:date])
    test_category     = TestCategoryMapping.where(:test_category => params["test_category"])
    if (params[:test_sub_category]=="")
      params[:test_sub_category]= test_category.select("test_sub_category").first[:test_sub_category]
    end
    meta_datum = test_metadatum.where(ci_job_name:                 (params[:ci_job_name]),
                                      platform_version:            (params[:platform_version]),
                                      os:                          (params[:os]),
                                      test_execution_machine_name: (params[:test_execution_machine_name]),
                                      browser_or_device:           (params[:browser_or_device]),
                                      environment:                 (params[:environment]),
                                      date_of_execution:           date_of_execution,
                                      test_category:               params[:test_category].upcase,
                                      test_report_type:            params[:test_report_type].upcase,
                                      test_sub_category:           params[:test_sub_category].upcase,
                                      branch:                      params[:branch]).first_or_create

    meta_datum.save
    test_sub_category_list = test_category.select("test_sub_category")
    if (!(params[:test_sub_category].in? test_sub_category_list.map { |test_sub_category| test_sub_category["test_sub_category"] }))
      new_test_sub_category_entry= TestCategoryMapping.create(:test_category => params[:test_category].upcase, :test_sub_category => params[:test_sub_category].upcase)
      new_test_sub_category_entry.save
    end
    return meta_datum
  end

  def parse_and_save_log_files(meta_datum, params)
    input_file_name  = params[:logDirectory].original_filename
    output_file_path = File.join(log_dir, input_file_name)
    input_file_path  = params[:logDirectory].path
    Parser.new.parse_test_log_files input_file_path, output_file_path, meta_datum.id, params[:test_report_type]
  end

  private

  def get_date_and_timestamp(date_input)
    date_object       = DateTime.strptime(date_input[:day]+' '+date_input[:month]+' '+date_input[:year]+' '+date_input[:hour]+' '+date_input[:minute], '%d %m %Y %H %M ')
    date_of_execution = date_object.strftime("%Y-%m-%d %H:%M:%S")
    date_of_execution
  end


  def log_dir
    FileUtils.mkdir_p($PROJECT_ROOT+"/../PROJECT_LOGS/"+product.name+ "/"+ name + "/" +Time.now.strftime("%d-%m-%y-%H:%M:%S"))
  end

  def uppercase_name
    self.name.upcase! if !self.name.nil?
  end

end
