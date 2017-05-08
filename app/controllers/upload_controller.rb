require "zip"
require 'nokogiri'
require 'fileutils'

class UploadController < ApplicationController
  def create
    product, platform, meta_data = parse_and_store_test_run_data
    redirect_to :action => :show, :product_id => product.id, :platform_id => platform.id, :product_meta_id => meta_data.id
  end

  def automatic
    time          =Time.now.to_s
    date          ={
        "year"   => DateTime.parse(time).strftime("%Y"),
        "month"  => DateTime.parse(time).strftime("%m"),
        "day"    => DateTime.parse(time).strftime("%d"),
        "hour"   => DateTime.parse(time).strftime("%H"),
        "minute" => DateTime.parse(time).strftime("%M")
    }
    params[:date] = date
    create
  end

  def show
    @product      = Product.find(params[:product_id])
    @platform     = @product.platforms.find(params[:platform_id])
    @product_meta = @platform.test_metadatum.find_by(params[:product_meta_id])
    begin
      respond_to do |format|
        flash[:notice] = "Product Successfully Saved!!"
        format.html
        format.json { render :json => @product }
      end
    end
  end

  def new
  end

  def get_test_sub_category
    @sub_category = TestCategoryMapping.new.get_sub_category(params["test_category"])
    render json: @sub_category
  end

  def get_default_test_sub_category
    @test_sub_category = TestCategoryMapping.where(:test_category => params["test_category"]).select("test_sub_category").first
    render json: @test_sub_category
  end

  private
  def parse_and_store_test_run_data
    product  = Product.where(name: (params[:product_name].split.join(' ').upcase)).first_or_create
    platform = product.add_platform(params)
    meta_data=platform.create_test_metadatum params
    platform.parse_and_save_log_files(meta_data, params)
    return product, platform, meta_data
  end
end



