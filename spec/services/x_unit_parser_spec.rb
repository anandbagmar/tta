require 'spec_helper'
describe XUnitParser do
  describe "parse xml" do
    it "parses xml and retrieves metadata" do

      parser = XUnitParser.new

      xml = <<-eos
              <?xml version='1.0' encoding='UTF-8'?>
              <testsuite tests="4" name="controllers.AccountAdminControllerTest" hostname="avinash-PC" failures="0" time="2.141" errors="0"/>
      eos

      xml_data = double("xml_data")
      JunitXmlDatum.stub(:new){xml_data}
      xml_data.should_receive(:save)

      parser.parse_xml(xml)
    end

  end
end