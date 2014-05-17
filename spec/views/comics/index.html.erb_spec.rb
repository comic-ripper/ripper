require 'spec_helper'

describe "comics/index" do
  before(:each) do
    assign(:comics, [
      stub_model(Comic,
        :title => "Title"
      ),
      stub_model(Comic,
        :title => "Title"
      )
    ])
  end

  it "renders a list of comics" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
