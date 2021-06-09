require 'rails_helper'

RSpec.describe Lesson, type: :model do

  before(:all) do
    @category = create(:category, name: "Anotherwe")
    @course = create(:course, name: "Mmmmmmweh", category: @category)
    @chapter = create(:chapter, title: "testwe title er", course: @course)
    @lesson = create(:lesson, chapter: @chapter)
  end
  
  it "is valid with valid attributes" do
    expect(@lesson).to be_valid
  end

  it "is not valid without a title" do
    lesson2 = build(:lesson, title: nil)
    expect(lesson2).to_not be_valid
  end

  it "has a unique title" do
    lesson2 = build(:lesson, title: "The first lesson")
    expect(lesson2).to_not be_valid
  end

  it "is not valid without a slug" do
    lesson2 = build(:lesson, slug: nil)
    expect(lesson2).to_not be_valid
  end

  it "has a unique slug" do
    lesson2 = build(:lesson, slug: "the-first-lesson")
    expect(lesson2).to_not be_valid
  end
  
  it "has a without description" do
    lesson2 = build(:lesson, description: nil)
    expect(lesson2).to_not be_valid
  end
  
  it "has a without content" do
    lesson2 = build(:lesson, content: nil)
    expect(lesson2).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:chapter)}
    it { should have_one(:course)}
  end
end
