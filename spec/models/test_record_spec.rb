require 'spec_helper'

describe TestRecord do
  describe "belongs to" do
   it "project_metadata" do
        should belong_to :project_metadatum
   end
  end
end
