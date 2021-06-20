require 'rails_helper'

RSpec.describe "Categories", type: :request do
  before(:all) do
    @category = create(:category, name: "this is a test")
    @user = create(:user, name: "kjssdfdfjf", email: "er@sdsdd.com", username: "dfsdisdhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "should get list of categories" do
    get '/categories'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should show a category" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    get "/categories/#{@category.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")     
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should get update a category" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    put "/categories/#{@category.slug}", :params => { category: {description: "Some description for test category"} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty   
    expect(response).to have_http_status(200)
  end

  it "should creates a Category" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    post "/categories", :params => { category: {:name => "My Category", description: "Some description"} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a Category" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/categories/#{@category.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

end