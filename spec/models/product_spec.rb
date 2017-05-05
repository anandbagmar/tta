require 'spec_helper'

describe Product do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "add_platform" do
    before(:each) do
      @attr = {:platform_name => "tta_sub", :ci_job_name => "build", :test_category => "Unit test", :test_report_type => "JUnit", :date => {:year => "2012", :month => "5", :day => "26", :hour => "07", :minute => "46"},
               :browser => "firefox", :host_name => "host_pc", :os_name => "mac-osx", :type_of_environment => "dev", :logDirectory => double(:original_filename => "abc.zip", :path => $PROJECT_ROOT+"/Err_test.zip")}
    end

    it "adds platform to under the product" do
      product = Fabricate(:product)
      product.platforms.should be_empty
      Parser.any_instance.stub(:unzip)
      platform, meta_data = product.add_platform(@attr)
      product.platforms.count.should == 1
      product.platforms.should include(platform)
    end
  end

  context "scope" do
    it "gets all the product record entries" do
      product1 = FactoryGirl.create(:product, name: 'tta1')
      product2 = FactoryGirl.create(:product, name: 'tta2')
      Product.get_all_products.count == 2
      Product.get_all_products.should == [product1, product2]
    end
  end
end


