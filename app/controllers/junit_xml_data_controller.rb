class JunitXmlDataController < ApplicationController
  # GET /junit_xml_data
  # GET /junit_xml_data.json
  def index
    @junit_xml_data = JunitXmlDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @junit_xml_data }
    end
  end

  # GET /junit_xml_data/1
  # GET /junit_xml_data/1.json
  def show
    @junit_xml_datum = JunitXmlDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @junit_xml_datum }
    end
  end

  # GET /junit_xml_data/new
  # GET /junit_xml_data/new.json
  def new
    @junit_xml_datum = JunitXmlDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @junit_xml_datum }
    end
  end

  # GET /junit_xml_data/1/edit
  def edit
    @junit_xml_datum = JunitXmlDatum.find(params[:id])
  end

  # POST /junit_xml_data
  # POST /junit_xml_data.json
  def create
    @junit_xml_datum = JunitXmlDatum.new(params[:junit_xml_datum])

    respond_to do |format|
      if @junit_xml_datum.save
        format.html { redirect_to @junit_xml_datum, notice: 'Junit xml datum was successfully created.' }
        format.json { render json: @junit_xml_datum, status: :created, location: @junit_xml_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @junit_xml_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /junit_xml_data/1
  # PUT /junit_xml_data/1.json
  def update
    @junit_xml_datum = JunitXmlDatum.find(params[:id])

    respond_to do |format|
      if @junit_xml_datum.update_attributes(params[:junit_xml_datum])
        format.html { redirect_to @junit_xml_datum, notice: 'Junit xml datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @junit_xml_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /junit_xml_data/1
  # DELETE /junit_xml_data/1.json
  def destroy
    @junit_xml_datum = JunitXmlDatum.find(params[:id])
    @junit_xml_datum.destroy

    respond_to do |format|
      format.html { redirect_to junit_xml_data_url }
      format.json { head :no_content }
    end
  end
end
