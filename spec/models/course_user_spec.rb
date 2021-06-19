require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  
  before(:all) do
    @category = create(:category, name: "Awewnsokdother")
    @user = create(:user, name: "kjwesfdswewdfjf", email: "ewesdwer@swedd.com", username: "dfiwesdwewewhfiu")
    @course = create(:course, name: "kajskjasd", category: @category, user: @user)
    @course_user = create(:courseUser, user_id: @user.id, course_id: @course.id)
  end

  it "has:" do
    expect(CourseUser).to respond_to(:verify).with(2).arguments
    expect(CourseUser.verify(@user.id, @course.id)).to eq(CourseUser.where('user_id =?  and course_id =? ', @user.id, @course.id).first)
  end

  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:course)}
  end
end


