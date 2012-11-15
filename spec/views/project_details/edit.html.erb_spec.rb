require 'spec_helper'

describe "project_details/edit" do
  before(:each) do
    @project_detail = assign(:project_detail, stub_model(ProjectDetail,
      :Name => "MyString",
      :Log_type => "MyString"
    ))
  end

  it "renders the edit project_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_details_path(@project_detail), :method => "post" do
      assert_select "input#project_detail_Name", :name => "project_detail[Name]"
      assert_select "input#project_detail_Log_type", :name => "project_detail[Log_type]"
    end
  end
end
