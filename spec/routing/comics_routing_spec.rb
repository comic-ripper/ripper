require "spec_helper"

describe ComicsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/comics").to route_to("comics#index")
    end

    it "routes to #new" do
      expect(:get => "/comics/new").to route_to("comics#new")
    end

    it "routes to #show" do
      expect(:get => "/comics/1").to route_to("comics#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/comics").to route_to("comics#create")
    end
  end
end
