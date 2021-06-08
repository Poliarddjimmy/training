require 'rails_helper'

RSpec.describe "Courses", type: :request do
  before(:all) do
    @category = create(:category, name: "Anotherwewe", slug: "anowethere")
    @course = create(:course, name: "this is another course for the test", slug: "this-is-another-course-for-the-test", category: @category)
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
    headers = { "ACCEPT" => "application/json" }
    post "/courses/", :params => { name: "My course", slug: "my-slug", description: "My description", category_id: 1  }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should update a course" do
    headers = { "ACCEPT" => "application/json" }
    put "/courses/#{@course.slug}", :params => { description: "Some description for test course" }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty   
    expect(response).to have_http_status(200)
  end

  it "should delete a course" do
    delete "/courses/#{@course.slug}"
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
  
end