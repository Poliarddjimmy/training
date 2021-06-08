require 'rails_helper'

RSpec.describe Chapter, type: :model do
  before(:all) do
    @category = create(:category, name: "Anothweewer", slug: "anweowether")
    @course = create(:course, slug: "weWoy", name: "Mmmmwemh", category: @category)
    @chapter = create(:chapter, course: @course)
  end
  
  it "is valid with valid attributes" do
    expect(@chapter).to be_valid
  end

  it "is not valid without a title" do
    chapter2 = build(:chapter, title: nil)
    expect(chapter2).to_not be_valid
  end

  it "has a unique title" do
    chapter2 = build(:chapter, title: "The first chapter")
    expect(chapter2).to_not be_valid
  end

  it "is not valid without a slug" do
    chapter2 = build(:chapter, slug: nil)
    expect(chapter2).to_not be_valid
  end

  it "has a unique slug" do
    chapter2 = build(:chapter, slug: "the-first-chapterd")
    expect(chapter2).to_not be_valid
  end
  
  it "has a without description" do
    chapter2 = build(:chapter, description: nil)
    expect(chapter2).to_not be_valid
  end
  
  it "has a without objective" do
    chapter2 = build(:chapter, objective: nil)
    expect(chapter2).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:course)}
    it { should have_many(:lessons)}
  end

end