require 'spec_helper'

describe CategoriesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    pending 'legacy test'
    it "returns http success" do
      pending 'legacy test'
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    pending 'legacy test'
    it "returns http success" do
      pending 'legacy test'
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    pending 'legacy test'
    it "returns http success" do
      pending 'legacy test'
      get 'new'
      response.should be_success
    end
  end

end
