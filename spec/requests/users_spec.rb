require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:all) do
    @user = create(:user, email: "someone@test.com", username: "testusername")
  end
  
  it "should get list of users" do
    get '/users'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response).to have_http_status(200)
    expect(response.content_type).not_to be_empty
  end

  it "Should return a user" do
    get "/users/#{@user.username}"
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(200)
    expect(response.content_type).not_to be_empty
  end

  it "Should create a user" do
    headers = { "ACCEPT" => "application/json" }
    post "/users/", :params => { :name => "My Category" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response).to have_http_status(200)
    expect(response.content_type).not_to be_empty
  end

  it "Should update a user" do
    headers = { "ACCEPT" => "application/json" }
    put "/users/#{@user.username}", :params => { :name => "My Category" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response).to have_http_status(200)
    expect(response.content_type).not_to be_empty
  end

  it "should delete a user" do
    delete "/users/#{@user.username}"
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response).to have_http_status(200)
    expect(response.content_type).not_to be_empty
  end
end