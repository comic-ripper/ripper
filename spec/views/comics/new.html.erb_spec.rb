require 'spec_helper'

describe "comics/new" do
  before(:each) do
    assign(:comic, stub_model(Comic,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new comic form" do
    render

    assert_select "form[action=?][method=?]", comics_path, "post" do
      assert_select "input#comic_title[name=?]", "comic[title]"
    end
  end
end
