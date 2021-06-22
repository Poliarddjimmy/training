require 'rails_helper'

RSpec.describe "Requirements", type: :request do
  before(:all) do
    @user = create(:user, name: "kjsfdsadsdfjf", email: "ewesdr@sddsd.com", username: "dfisdwasdqewhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
    @category = create(:category, name: "asdfrfweweas")
    @course = create(:course, name: "hsdbfjfrernoifj", category: @category, user: @user)
    @requirement = create(:requirement, content:"kjshd hiwuehiur ej rifhsdiwefi", course: @course)
  end

  it "Should return a requirement" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}"  }
    get "/requirements/#{@requirement.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should create a requirement" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    post "/requirements/", :params => { requirement: {content: "Test requirement", duration: "1000", course_id: 1} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update a requirement" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/requirements/#{@requirement.id}", :params => { requirement: { :content => "My requirement"} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a requirement" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/requirements/#{@requirement.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
