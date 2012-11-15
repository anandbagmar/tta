require 'spec_helper'

describe "project_deatils/edit" do
  before(:each) do
    @project_deatil = assign(:project_deatil, stub_model(ProjectDeatil,
      :Name => "MyString",
      :Log_type => "MyString"
    ))
  end

  it "renders the edit project_deatil form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_deatils_path(@project_deatil), :method => "post" do
      assert_select "input#project_deatil_Name", :name => "project_deatil[Name]"
      assert_select "input#project_deatil_Log_type", :name => "project_deatil[Log_type]"
    end
  end
end
