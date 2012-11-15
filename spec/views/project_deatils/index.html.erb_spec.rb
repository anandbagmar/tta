require 'spec_helper'

describe "project_deatils/index" do
  before(:each) do
    assign(:project_deatils, [
      stub_model(ProjectDeatil,
        :Name => "Name",
        :Log_type => "Log Type"
      ),
      stub_model(ProjectDeatil,
        :Name => "Name",
        :Log_type => "Log Type"
      )
    ])
  end

  it "renders a list of project_deatils" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Log Type".to_s, :count => 2
  end
end
