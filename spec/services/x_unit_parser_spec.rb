require 'spec_helper'
describe XUnitParser do
  describe "parse xml" do

    before(:all) do
        @parser = XUnitParser.new
    end

    it "parses xml and retrieves metadata" do

      xml = <<-eos
              <?xml version='1.0' encoding='UTF-8'?>
              <testsuite tests="4"
                         name="controllers.AccountAdminControllerTest"
                         hostname="avinash-PC"
                         failures="0"
                         time="2.141"
                         errors="0"
              />
      eos

      xml_data = double("xml_data")
      TestRecord.should_receive(:new).and_return(xml_data)
      xml_data.should_receive(:save)

      @parser.parse_xml(xml)
    end

  end
end