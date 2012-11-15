require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :Name => "Name",
      :of => "Of",
      :project => "Project",
      :Log => "Log",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Of/)
    rendered.should match(/Project/)
    rendered.should match(/Log/)
    rendered.should match(/Type/)
  end
end
