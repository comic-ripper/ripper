require 'spec_helper'

describe "comics/edit" do
  before(:each) do
    @comic = assign(:comic, stub_model(Comic,
      :title => "MyString"
    ))
  end

  it "renders the edit comic form" do
    render

    assert_select "form[action=?][method=?]", comic_path(@comic), "post" do
      assert_select "input#comic_title[name=?]", "comic[title]"
    end
  end
end
