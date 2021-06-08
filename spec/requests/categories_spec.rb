require 'rails_helper'

RSpec.describe "Categories", type: :request do
  before(:all) do
    @category = create(:category, name: "this is a test", slug: "this-is-a-test")
  end

  it "should get list of categories" do
    get '/categories'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should show a category" do
    get "/categories/#{@category.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")     
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should get update a category" do
    headers = { "ACCEPT" => "application/json" }
    put "/categories/#{@category.slug}", :params => { description: "Some description for test category" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty   
    expect(response).to have_http_status(200)
  end

  it "should creates a Category" do
    headers = { "ACCEPT" => "application/json" }
    post "/categories", :params => { :name => "My Category" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a Category" do
    delete "/categories/#{@category.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

end