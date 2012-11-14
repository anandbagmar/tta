class JUnitXmlsController < ApplicationController
  # GET /j_unit_xmls
  # GET /j_unit_xmls.json
  def index
    @j_unit_xmls = JUnitXml.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @j_unit_xmls }
    end
  end

  # GET /j_unit_xmls/1
  # GET /j_unit_xmls/1.json
  def show
    @j_unit_xml = JUnitXml.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @j_unit_xml }
    end
  end

  # GET /j_unit_xmls/new
  # GET /j_unit_xmls/new.json
  def new
    @j_unit_xml = JUnitXml.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @j_unit_xml }
    end
  end

  # GET /j_unit_xmls/1/edit
  def edit
    @j_unit_xml = JUnitXml.find(params[:id])
  end

  # POST /j_unit_xmls
  # POST /j_unit_xmls.json
  def create
    @j_unit_xml = JUnitXml.new(params[:j_unit_xml])
    parser = XUnitParser.new
    parser.parse_xml(params[:j_unit_xml][:contentxml])

    respond_to do |format|
      if @j_unit_xml.save
        format.html { redirect_to @j_unit_xml, notice: 'J unit xml was successfully created.' }
        format.json { render json: @j_unit_xml, status: :created, location: @j_unit_xml }
      else
        format.html { render action: "new" }
        format.json { render json: @j_unit_xml.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /j_unit_xmls/1
  # PUT /j_unit_xmls/1.json
  def update
    @j_unit_xml = JUnitXml.find(params[:id])

    respond_to do |format|
      if @j_unit_xml.update_attributes(params[:j_unit_xml])
        format.html { redirect_to @j_unit_xml, notice: 'J unit xml was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @j_unit_xml.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /j_unit_xmls/1
  # DELETE /j_unit_xmls/1.json
  def destroy
    @j_unit_xml = JUnitXml.find(params[:id])
    @j_unit_xml.destroy

    respond_to do |format|
      format.html { redirect_to j_unit_xmls_url }
      format.json { head :no_content }
    end
  end
end
