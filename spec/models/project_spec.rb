require 'spec_helper'

describe Project do
  describe "create" do
    it "active record validations" do
      should validate_uniqueness_of :name
      should validate_presence_of :name
    end
  end
end
