require "spec_helper"


describe UploadController do
  describe "routing" do
    it " routes to upload/create" do
      assert_generates '/upload/create', :controller => 'upload', :action => 'create'
    end

    it " routes to upload/show" do
      assert_generates '/upload/show', :controller => 'upload', :action => 'show'
    end

    it " routes to upload" do
      assert_generates '/upload', :controller => 'upload', :action => 'new'
    end
  end
end
