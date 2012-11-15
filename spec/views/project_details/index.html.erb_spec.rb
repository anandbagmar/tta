require 'spec_helper'

describe "project_details/index" do
  before(:each) do
    assign(:project_details, [
      stub_model(ProjectDetail,
        :Name => "Name",
        :Log_type => "Log Type"
      ),
      stub_model(ProjectDetail,
        :Name => "Name",
        :Log_type => "Log Type"
      )
    ])
  end

  it "renders a list of project_details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Log Type".to_s, :count => 2
  end
end
