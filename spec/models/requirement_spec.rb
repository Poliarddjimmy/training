require 'rails_helper'

RSpec.describe Requirement, type: :model do

  before(:all) do
    @category = create(:category, name: "Anotiuhihweewer")
    @course = create(:course, name: "Mmkjmmwemh", category: @category)
    @requirement = create(:requirement, duration: "1000", content: "this is good content", course: @course)
  end
  
  it "is valid with valid attributes" do
    expect(@requirement).to be_valid
  end

  it "has a without content" do
    requirement2 = build(:requirement, content: nil)
    expect(requirement2).to_not be_valid
  end

  it "has a without duration" do
    requirement2 = build(:requirement, duration: nil)
    expect(requirement2).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:course)}
  end
end
