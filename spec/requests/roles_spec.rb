require 'rails_helper'

RSpec.describe "Roles", type: :request do
  before(:all) do
    @role = create(:role, name: "this is a test")
    @user = create(:user, name: "kjssdsdfdfjf", email: "er@ssddsdd.com", username: "dfssddisdhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "should get list of roles" do
    get '/roles'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should show a role" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    get "/roles/#{@role.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")     
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should get update a role" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    put "/roles/#{@role.slug}", :params => { role: {name: "another name"} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty   
    expect(response).to have_http_status(200)
  end

  it "should creates a role" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    post "/roles", :params => { role: {:name => "My role"} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a role" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/roles/#{@role.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end
end
