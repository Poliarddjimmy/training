require 'rails_helper'

RSpec.describe Course, type: :model do

  before(:all) do
    @category = create(:category, name: "Another")
    @course = create(:course, category: @category)
  end
  
  it "is valid with valid attributes" do
    expect(@course).to be_valid
  end

  it "is not valid without a name" do
    course2 = build(:course, name: nil)
    expect(course2).to_not be_valid
  end

  it "has a unique name" do
    course2 = build(:course, name: "The first course")
    expect(course2).to_not be_valid
  end
  
  it "has a without description" do
    course2 = build(:course, description: nil)
    expect(course2).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:category)}
    it { should have_many(:chapters)}
  end
end
