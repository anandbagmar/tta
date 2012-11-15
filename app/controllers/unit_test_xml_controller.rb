class UnitTestXmlController < ApplicationController
  def index
  end

  def new
  end

  def show
    @id = params[:id]
    @image = UnitTestXml.find(@id)
  end

  def create
    @unit_test_xml = UnitTestXml.new(params[:xml])
    if @unit_test_xml.save
      redirect_to :action => :show, :id => @unit_test_xml.id
    end
  end
end
