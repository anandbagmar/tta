require 'spec_helper'
describe JUnitXmlsController do
  describe "GET index" do

    fixtures :j_unit_xmls

    it "assigns all junit xmls" do
      get :index
      response.should be_success
      expect(assigns(:j_unit_xmls)).to eq(JUnitXml.all)
    end

    it "renders the index template" do
         get :index
         response.should render_template("index")
       end
  end
end