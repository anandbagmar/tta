require 'spec_helper'

describe UploadController, type: :controller do

  context "GET 'upload'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  context "Upload data" do

    before(:each) do
      create_or_load_product_if_not_present
      @file_with_errors   = fixture_file_upload('/proj1.zip', 'application/zip')
      @upload_with_errors = { :product_name                => @product.name,
                              :platform_name               => @platform.name,
                              :ci_job_name                 => @meta_data[:ci_job_name],
                              :test_category               => @meta_data[:test_category],
                              :test_sub_category           => @meta_data[:test_sub_category],
                              :test_report_type            => @meta_data[:test_report_type],
                              :date                        => { "year" => "2013", "month" => "2", "day" => "20", "hour" => "00", "minute" => "00" },
                              :browser_or_device           => @meta_data[:browser_or_device],
                              :test_execution_machine_name => @meta_data[:test_execution_machine_name],
                              :os                          => @meta_data[:os],
                              :environment                 => @meta_data[:environment],
                              :logDirectory                => @file_with_errors }
    end

    it "uploads data with failure messages" do
      post :create, @upload_with_errors
      redirect_params = Rack::Utils.parse_query(URI.parse(response.location).query)
      response.should redirect_to upload_show_path(:product_id => @product.id, :product_meta_id => redirect_params["product_meta_id"], :platform_id => @platform.id)
    end

  end

  context "Upload data" do

    before(:each) do
      create_or_load_product_if_not_present
      @file_without_errors   = fixture_file_upload('/proj5.zip', 'application/zip')
      @upload_without_errors = { :product_name                => @product.name,
                                 :platform_name               => @platform.name,
                                 :ci_job_name                 => @meta_data[:ci_job_name],
                                 :branch                      => @meta_data[:branch],
                                 :test_category               => @meta_data[:test_category],
                                 :test_sub_category           => @meta_data[:test_sub_category],
                                 :test_report_type            => @meta_data[:test_report_type],
                                 :date                        => { "year" => "2013", "month" => "2", "day" => "20", "hour" => "00", "minute" => "00" },
                                 :browser_or_device           => @meta_data[:browser_or_device],
                                 :test_execution_machine_name => @meta_data[:test_execution_machine_name],
                                 :os                          => @meta_data[:os],
                                 :environment                 => @meta_data[:environment],
                                 :logDirectory                => @file_without_errors }
    end

    it "uploads data and redirect to success page" do
      post :create, @upload_without_errors
      redirect_params = Rack::Utils.parse_query(URI.parse(response.location).query)
      response.should redirect_to upload_show_path(:product_id => @product.id, :product_meta_id => redirect_params["product_meta_id"], :platform_id => @platform.id)
    end

    it "check success page shows the product details" do
      post :create, @upload_without_errors
      redirect_params = Rack::Utils.parse_query(URI.parse(response.location).query)
      get :show, { :product_id => @product.id, :product_meta_id => redirect_params["product_meta_id"], :platform_id => @platform.id }
      response.should render_template :show
      response.code.should eq("200")
      assigns[:product].should == @product
      assigns[:platform].should == @platform
      assigns[:product_meta][:ci_job_name].should match (/#{@meta_data[:ci_job_name]}/i)
      assigns[:product_meta][:branch].should match (/#{@meta_data[:branch]}/i)
      assigns[:product_meta][:os].should match (/#{@meta_data[:os]}/i)
      assigns[:product_meta][:test_execution_machine_name].should match (/#{@meta_data[:test_execution_machine_name]}/i)
      assigns[:product_meta][:browser_or_device].should match (/#{@meta_data[:browser_or_device]}/i)
      assigns[:product_meta][:environment].should match (/#{@meta_data[:environment]}/i)
      assigns[:product_meta][:test_category].should match (/#{@meta_data[:test_category]}/i)
      assigns[:product_meta][:test_report_type].should match (/#{@meta_data[:test_report_type]}/i)
      assigns[:product_meta][:test_sub_category].should match (/#{@meta_data[:test_sub_category]}/i)
      flash[:notice].should == "Product Successfully Saved!!"
    end

  end

  context "Upload data" do
    it "should return relevant list of test sub category for selected test category" do
      if (TestCategoryMapping.select("test_category") == [])
        FactoryGirl.create(:test_category_mapping)
      end
      get :get_test_sub_category, { test_category: "UNIT TEST" }
      JSON.parse(response.body).should == [{ 'id' => nil, 'test_sub_category' => 'UNIT TEST' }]
    end
  end
end

def create_or_load_product_if_not_present
  @product   ||= FactoryGirl.create(:product)
  @platform  ||= FactoryGirl.create(:platform, :product_id => @product.id)
  @meta_data ||= FactoryGirl.build(:test_metadatum, :platform_id => @platform.id)
end