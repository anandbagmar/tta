require 'spec_helper'
describe JUnitXml do
  describe "create" do
    it "creates Junit Xml" do
      xml =JUnitXml.create!(:name => "MyString",
                            :contentxml => "<?xml version='1.0' encoding='UTF-8'?><testsuite></testsuite>"
      )
      expect(JUnitXml.last).to eq(xml)
    end
  end
end