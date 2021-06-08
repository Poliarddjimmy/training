require 'rails_helper'

RSpec.describe "Chapters", type: :request do
  before(:all) do
    @category = create(:category, name: "asdweas", slug: "qwweeqweqwe")
    @course = create(:course, name: "hsdbfjnoifj", slug: "sdsds-sds-dsds-dsds-sd", category: @category)
    @chapter = create(:chapter, title:"kjshdfhsdiwefi", slug:"adwqwewe-efwewr-ewerw", course: @course)
  end

  it "should get list of chapters" do
    get '/chapters'
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should return a chapter" do
    get "/chapters/#{@chapter.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "Should create a chapter" do
    headers = { "ACCEPT" => "application/json" }
    post "/chapters/", :params => { title: "Test chapter", slug: "test-slug", description: "Some description for test chapter", objective: "This is the objective", course_id: 1 }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(200)
  end

  it "Should update a chapter" do
    headers = { "ACCEPT" => "application/json" }
    put "/chapters/#{@chapter.slug}", :params => { :desctiption => "My chapter" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete a chapter" do
    delete "/chapters/#{@chapter.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
