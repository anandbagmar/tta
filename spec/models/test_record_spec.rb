require 'spec_helper'

describe TestRecord do
  describe "belongs to" do
   it "test_metadata" do
        should belong_to :test_metadatum
   end
  end
end
