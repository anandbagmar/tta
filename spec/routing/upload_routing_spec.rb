require "spec_helper"


describe UploadController do
  describe "routing" do
    it " routes to upload/upload" do
      assert_generates '/upload/upload', :controller => 'upload', :action => 'create'
    end

    it " routes to upload/show" do
      assert_generates '/upload/show', :controller => 'upload', :action => 'show'
    end
  end
end
