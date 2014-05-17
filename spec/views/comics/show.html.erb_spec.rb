require 'spec_helper'

describe "comics/show" do
  before(:each) do
    @comic = assign(:comic, stub_model(Comic,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
