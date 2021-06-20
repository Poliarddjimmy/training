require 'rails_helper'

RSpec.describe "CourseUsers", type: :request do

  before(:all) do
    @category = create(:category, name: "asdedweweas")
    @user = create(:user, name: "kjsfdsdfedjf", email: "ewesdder@sdd.com", username: "dfisdedwewhfiu")
    @course = create(:course, name: "hsdbdefjnoifj", category: @category, user: @user)
    @course_user = create(:course_user, user: @user, course: @course)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "Should create" do
    headers = { "ACCEPT" => "application/json" }
    post "/course_users/", :params => { course_user: {user_id: @user.id, course_id: @course.id} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/course_users/#{@course_user.id}", :params => { course_user: {:confirm => true } }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/course_users/#{@course_user.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
