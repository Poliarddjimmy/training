require 'rails_helper'

RSpec.describe Lesson, type: :model do

  before(:all) do
    @category = create(:category, name: "Anotherwe")
    @course = create(:course, name: "Mmmmmmweh", category: @category)
    @chapter = create(:chapter, title: "testwe title er", course: @course)
    @lesson = create(:lesson, chapter: @chapter)
    @user = create(:user, name: "kjsfddswewdfjf", email: "ewesddr@swedd.com", username: "dsfisdwewewhfiu")
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
  
  it "has a without description" do
    lesson2 = build(:lesson, description: nil)
    expect(lesson2).to_not be_valid
  end
  
  it "has a without content" do
    lesson2 = build(:lesson, content: nil)
    expect(lesson2).to_not be_valid
  end

  it "has:" do
    expect(@lesson).to respond_to(:as_json).with(1).argument
    expect(@lesson).to respond_to(:next_lesson, :previous_lesson, :next_lesson_by_chapter,:previous_lesson_by_chapter)

    expect(@lesson.next_lesson).to eq(Lesson.where('chapter_id = ?and id > ?',  @lesson.chapter_id, @lesson.id).first)
    expect(@lesson.previous_lesson).to eq(Lesson.where('chapter_id = ?and id < ?',  @lesson.chapter_id, @lesson.id).first)
    expect(@lesson.next_lesson_by_chapter).to eq(@lesson.course.chapters.where("id > #{@lesson.chapter.id}").first )
    expect(@lesson.previous_lesson_by_chapter).to eq(@lesson.course.chapters.where("id < #{@lesson.chapter.id}").first )
  end

  it "returns the specified value on any instance of the class" do
    allow_any_instance_of(Lesson).to receive(:set_slug).and_return(@lesson.title.to_s.parameterize)

    expect(@lesson.set_slug).to eq(@lesson.title.to_s.parameterize)
  end

  describe "Associations" do
    it { should belong_to(:chapter)}
    it { should have_one(:course)}
    it { should have_many(:users)}
  end
end
