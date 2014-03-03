require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      pending 'legacy test'
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
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

  describe "GET 'create'" do
    it "returns http success" do
      pending 'legacy test'
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      pending 'legacy test'
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      pending 'legacy test'
      get 'destroy'
      response.should be_success
    end
  end

end
