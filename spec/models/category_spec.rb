require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:all) do
    @category = create(:category, name: "Another category")
  end
  
  it "is valid with valid attributes" do
    expect(@category).to be_valid
  end

  it "is not valid without a name" do
    category2 = build(:category, name: nil)
    expect(category2).to_not be_valid
  end

  it "has a unique name" do
    category2 = build(:category, name: "Another category")
    expect(category2).to_not be_valid
  end
  
  it "has a without description" do
    category2 = build(:category, description: nil)
    expect(category2).to_not be_valid
  end
end
