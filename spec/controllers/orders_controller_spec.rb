require 'spec_helper'

describe OrdersController do

  describe "GET 'show'" do
    it "returns http success" do
      pending 'legacy test'
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      pending 'legacy test'
      get 'edit'
      response.should be_success
    end
  end

end
