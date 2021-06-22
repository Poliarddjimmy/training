require 'rails_helper'

RSpec.describe RoleUser, type: :model do
  before(:all) do
    @user = create(:user, name: "kjwesfdswewerdfjf", email: "ewesdweerr@swedd.comer", username: "dfiwesderwewewhfiu")
    @role = create(:role, name: "kajskjasd")
    @role_user = create(:role_user, user_id: @user.id, role_id: @role.id)
  end

  it "is valid with valid attributes" do
    expect(@role_user).to be_valid
  end

  it "has:" do
    expect(RoleUser).to respond_to(:verify).with(1).arguments
    expect(RoleUser.verify(@user.id)).to eq(RoleUser.where('user_id =?', @user.id).first)
  end

  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:role)}
  end
end
