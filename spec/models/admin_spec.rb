require 'spec_helper'
require 'rspec'

describe Admin do
  it "should return message if no products in database" do
    json       = Admin.get_result_json
    parse_json = ActiveSupport::JSON.decode(json)
    parse_json.has_key?("message")
  end

  date_of_execution = "2013-02-02"
  it "should not return nil json when admin_url is hit" do
    date_of_execution = "2013-02-02"
    product1          = FactoryGirl.create(:product, :name => "TTA1")
    platform11        = FactoryGirl.create(:platform, :product_id => product1.id, :name => "TTA_pLATFORM1")
    FactoryGirl.create(:test_metadatum, :platform_id => platform11.id, :date_of_execution => date_of_execution, :branch => "master")
    product2   = FactoryGirl.create(:product, :name => "TTA2")
    platform21 = FactoryGirl.create(:platform, :product_id => product2.id, :name => "TTA_pLATFORM2")
    FactoryGirl.create(:test_metadatum, :platform_id => platform21.id, :date_of_execution => date_of_execution, :branch => "master")
    product=Array.new
    product.push(product1)
    product.push(product2)
    json = Admin.get_result_json(product)
    json.should_not be_nil
  end

  it "should return correct count in json" do
    date_of_execution = "2013-02-02"
    product1          = FactoryGirl.create(:product, :name => "TTA11")
    platform11        = FactoryGirl.create(:platform, :product_id => product1.id, :name => "TTA_pLATFORM11")
    FactoryGirl.create(:test_metadatum, :platform_id => platform11.id, :date_of_execution => date_of_execution, :branch => "master")
    platform12 = FactoryGirl.create(:platform, :product_id => product1.id, :name => "TTA_pLATFORM12")
    FactoryGirl.create(:test_metadatum, :platform_id => platform12.id, :date_of_execution => date_of_execution, :branch => "master")
    FactoryGirl.create(:test_metadatum, :platform_id => platform12.id, :date_of_execution => date_of_execution, :branch => "master")
    FactoryGirl.create(:test_metadatum, :platform_id => platform12.id, :date_of_execution => date_of_execution, :branch => "master")

    product2   = FactoryGirl.create(:product, :name => "TTA12")
    platform21 = FactoryGirl.create(:platform, :product_id => product2.id, :name => "TTA_pLATFORM21")
    FactoryGirl.create(:test_metadatum, :platform_id => platform21.id, :date_of_execution => date_of_execution, :branch => "master")
    FactoryGirl.create(:test_metadatum, :platform_id => platform21.id, :date_of_execution => date_of_execution, :branch => "master")
    platform22 = FactoryGirl.create(:platform, :product_id => product2.id, :name => "TTA_pLATFORM22")
    FactoryGirl.create(:test_metadatum, :platform_id => platform22.id, :date_of_execution => date_of_execution, :branch => "master")
    FactoryGirl.create(:test_metadatum, :platform_id => platform22.id, :date_of_execution => "2013-02-02", :branch => "master")

    expect_json= { "#{product1.id}" => [{ "product_name" => "#{product1.name}" },
                                        { "platforms" => ["#{platform11.name}", "#{platform12.name}"] },
                                        { "test_count" => [1, 3] }],
                   "#{product2.id}" => [{ "product_name" => "#{product2.name}" },
                                        { "platforms" => ["#{platform21.name}", "#{platform22.name}"] },
                                        { "test_count" => [2, 2] }]
    }

    product=Array.new
    product.push(product1)
    product.push(product2)
    actual_json = Admin.get_result_json(product)
    parse_json  = ActiveSupport::JSON.decode(actual_json)

    parse_json.should eq(expect_json)
  end
end
