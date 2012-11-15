require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :Name => "MyString",
      :of => "MyString",
      :project => "MyString",
      :Log => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_Name", :name => "project[Name]"
      assert_select "input#project_of", :name => "project[of]"
      assert_select "input#project_project", :name => "project[project]"
      assert_select "input#project_Log", :name => "project[Log]"
      assert_select "input#project_type", :name => "project[type]"
    end
  end
end
