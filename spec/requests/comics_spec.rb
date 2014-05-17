require 'spec_helper'

describe "Comics" do
  describe "GET /comics" do
    it "works! (now write some real specs)" do
      get comics_path
      expect(response.status).to be(200)
    end
  end
end
