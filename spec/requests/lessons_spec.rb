require 'rails_helper'

RSpec.describe "Lessons", type: :request do

  before(:all) do
    @category = create(:category, name: "aswsweewrdas")
    @course = create(:course, name: "hsdbfjnoifwerjw", category: @category)
    @chapter = create(:chapter, title:"kjshdfhsdifiwwerwe", course: @course)
    @lesson = create(:lesson, title: "khaiuawqsddwe", chapter: @chapter)
  end

  it "should get list of lessons" do
    get '/lessons'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should return a lesson" do
    get "/lessons/#{@lesson.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should create a lesson" do
    headers = { "ACCEPT" => "application/json" }
    post "/lessons/", :params => { :title => "My lesson", description: "The description", content: "The content", chapter_id: 1 }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should update a lesson" do
    headers = { "ACCEPT" => "application/json" }
    put "/lessons/#{@lesson.slug}", :params => { :name => "My lesson" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a lesson" do
    delete "/lessons/#{@lesson.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end
end
