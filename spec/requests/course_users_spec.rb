require 'rails_helper'

RSpec.describe "CourseUsers", type: :request do

  before(:all) do
    @category = create(:category, name: "asdedweweas")
    @course = create(:course, name: "hsdbdefjnoifj", category: @category)
    @user = create(:user, name: "kjsfdsdfedjf", email: "ewesdder@sdd.com", username: "dfisdedwewhfiu")
    @courseUser = create(:courseUser, user: @user, course: @course)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "Should create" do
    headers = { "ACCEPT" => "application/json" }
    post "/course_users/", :params => { user_id: @user.id, course_id: @course.id}, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/course_users/#{@courseUser.id}", :params => { :confirm => true }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/course_users/#{@courseUser.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
