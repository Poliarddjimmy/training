require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:all) do
    @role = create(:role, name: "Another role")
  end

  it "is not valid without a name" do
    @role1 = build(:role, name: nil)
    expect(@role1).to_not be_valid
  end

  it "has a unique name" do
    @role1 = build(:role, name: "Another role")
    expect(@role1).to_not be_valid
  end

  it "has:" do
    expect(@role).to respond_to(:as_json).with(1).argument
  end

  it "returns the specified value on any instance of the class" do
    allow_any_instance_of(Role).to receive(:set_slug).and_return(@role.name.to_s.parameterize)
    expect(@role.set_slug).to eq(@role.name.to_s.parameterize)
  end

  describe "Associations" do
    it { should have_many(:role_users)}
  end
end
