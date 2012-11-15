require 'spec_helper'

describe "project_details/show" do
  before(:each) do
    @project_detail = assign(:project_detail, stub_model(ProjectDetail,
      :Name => "Name",
      :Log_type => "Log Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Log Type/)
  end
end
