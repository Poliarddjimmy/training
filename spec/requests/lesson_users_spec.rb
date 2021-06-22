require 'rails_helper'

RSpec.describe "LessonUsers", type: :request do
  before(:all) do
    @user = create(:user, name: "kjsfdssddfedjf", email: "ewesdsder@sdd.com", username: "dsdfisdedwewhfiu")
    @token = JsonWebToken.encode(user_id: @user.id)
    @category = create(:category, name: "assddedweweas")
    @course = create(:course, name: "hsdbdefjdsnoifj", category: @category, user: @user)
    @chapter = create(:chapter, title:"kjshdfhssddifiwwerwe", course: @course)
    @lesson = create(:lesson, title: "khasdisduawqsddwe", chapter: @chapter)
    @lessonUser = create(:lesson_user, user: @user, lesson: @lesson)
  end

  it "Should create" do
    headers = { "ACCEPT" => "application/json" }
    post "/lesson_users/", :params => { lesson_user: {user_id: @user.id, lesson_id: @lesson.id}}, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/lesson_users/#{@lessonUser.id}", :params => { lesson_user: {:user_id => @user.id }}, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/lesson_users/#{@lessonUser.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
