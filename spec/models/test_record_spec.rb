require 'spec_helper'

describe TestSuiteRecord do
  describe "belongs to" do
   it "test_metadata" do
        should belong_to :test_metadatum
   end
  end
end
