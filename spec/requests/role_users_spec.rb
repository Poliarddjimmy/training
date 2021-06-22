require 'rails_helper'

RSpec.describe "RoleUsers", type: :request do
  before(:all) do
    @user = create(:user, name: "kjsfdsdfeedwdjf", email: "ewesdwder@sdd.ecodwm", username: "dfwdeisdedwewhfiu")
    @role = create(:role, name: "hsdbeeeeedefjsdnoifj")
    @role_user = create(:role_user, user: @user, role: @role)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  it "Should create" do
    headers = { "ACCEPT" => "application/json" }
    post "/role_users/", :params => { role_user: {user_id: @user.id, role_id: @role.id} }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")   
    expect(response.content_type).not_to be_empty 
    expect(response).to have_http_status(201)
  end

  it "Should update" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    put "/role_users/#{@role_user.id}", :params => { role_user: {:user_id => @user.id } }, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")    
    expect(response.content_type).not_to be_empty
    expect(response).to have_http_status(200)
  end

  it "should delete" do
    headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{@token}" }
    delete "/role_users/#{@role_user.id}", :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")  
    expect(response.content_type).not_to be_empty  
    expect(response).to have_http_status(200)
  end
end
