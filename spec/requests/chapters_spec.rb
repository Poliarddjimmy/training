require 'rails_helper'

RSpec.describe "Chapters", type: :request do
  before(:all) do
    @category = create(:category, name: "asdweweas")
    @course = create(:course, name: "hsdbfjnoifj", category: @category)
    @chapter = create(:chapter, title:"kjshdfhsdiwefi", course: @course)
    @user = create(:user, name: "kjsfdsdfjf", email: "ewesdr@sdd.com", username: "dfisdwewhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "should get list of chapters" do
    get '/chapters'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should return a chapter" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    get "/chapters/#{@chapter.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should create a chapter" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    post "/chapters/", :params => { title: "Test chapter", description: "Some description for test chapter", objective: "This is the objective", course_id: 1 }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update a chapter" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/chapters/#{@chapter.slug}", :params => { :desctiption => "My chapter" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a chapter" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/chapters/#{@chapter.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
