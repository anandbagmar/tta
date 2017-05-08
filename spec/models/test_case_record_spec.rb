require 'spec_helper'

describe TestCaseRecord do

  describe "belongs to" do
    it "test_suite_record" do
      should belong_to :test_suite_record
    end
  end
end
