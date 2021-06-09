require 'rails_helper'

RSpec.describe "Courses", type: :request do
  before(:all) do
    @category = create(:category, name: "Anotherwewe")
    @course = create(:course, name: "this is another course for the test", category: @category)
    @user = create(:user, name: "kjsdrrffjf", email: "egrfrr@sd.com", username: "isasddhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "should get list of courses" do
    get '/courses'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should return a course" do
    get "/courses/#{@course.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should create a course" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    post "/courses/", :params => { name: "My course", description: "My description", category_id: 1  }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should update a course" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/courses/#{@course.slug}", :params => { description: "Some description for test course" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty   
    expect(response).to have_http_status(200)
  end

  it "should delete a course" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/courses/#{@course.slug}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
  
end