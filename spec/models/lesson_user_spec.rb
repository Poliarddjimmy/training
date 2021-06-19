require 'rails_helper'

RSpec.describe LessonUser, type: :model do
  before(:all) do
    @user = create(:user, name: "kjwesfdswewdfsdjf", email: "ewesdwer@swesddd.com", username: "dfiwesdsdwewewhfiu")
    @category = create(:category, name: "Awewwensokdother")
    @course = create(:course, name: "kajweskjasd", category: @category, user: @user)
    @chapter = create(:chapter, title: "teswetwe title er", course: @course)
    @lesson = create(:lesson, title: "teswetasgdwe title er", chapter: @chapter)

    @course_user = create(:courseUser, user_id: @user.id, course_id: @course.id)
  end

  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:lesson)}
  end

  it "has:" do
    expect(LessonUser).to respond_to(:verify).with(2).arguments
    expect(LessonUser.verify(@user.id, @lesson.id)).to eq(LessonUser.where('user_id =?  and lesson_id =? ', @user.id, @lesson.id).first)
  end
end
