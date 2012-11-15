require 'spec_helper'

describe "project_details/new" do
  before(:each) do
    assign(:project_detail, stub_model(ProjectDetail,
      :Name => "MyString",
      :Log_type => "MyString"
    ).as_new_record)
  end

  it "renders new project_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_details_path, :method => "post" do
      assert_select "input#project_detail_Name", :name => "project_detail[Name]"
      assert_select "input#project_detail_Log_type", :name => "project_detail[Log_type]"
    end
  end
end
