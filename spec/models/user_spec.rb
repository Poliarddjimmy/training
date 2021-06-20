# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:all) do
    @user1 = create(:user, name: "khdda", email: "hadbah@jkasdkjas.com", username: "jasdjjsadj")
    @category = create(:category, name: "Anrerdfdeother")
    @course = create(:course, name: "ahsiduasd", category: @category, user: @user1)
    @chapter = create(:chapter, title: "testwwee title er", course: @course)
    @lesson = create(:lesson, title: "kasdkjd", slug: "jkasdkoiqow", chapter: @chapter)
  end
  
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end
  
  it "has a unique username" do
    user2 = build(:user, username: "jasdjjsadj")
    expect(user2).to_not be_valid
  end
  
  it "has a unique email" do
    user2 = build(:user, email: "hadbah@jkasdkjas.com")
    expect(user2).to_not be_valid
  end
  
  it "is not valid without a password" do 
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end
  
  it "is not valid without a username" do 
    user2 = build(:user, username: nil)
    expect(user2).to_not be_valid
  end
  
  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end
  
  it "is not valid without a name" do
    user2 = build(:user, name: nil)
    expect(user2).to_not be_valid
  end

  it "has:" do
    expect(@user1).to respond_to(:subscribed, :completed_by_me, :as_json).with(1).argument 
    expect(@user1).to respond_to(:admin, :teacher) 

    expect(@user1.admin).to  eq(false)
    expect(@user1.teacher).to  eq(false)
    expect(@user1.completed_by_me(@lesson.slug)).to eq(@user1.lessons.where(slug: @lesson.slug).first)
    expect(@user1.subscribed(@course.slug)).to eq(@user1.courses.where(slug: @course.slug).first)
  end

  describe "Associations" do
    it { should have_many(:courses)}
    it { should have_many(:lessons)}
    it { should have_many(:role_users)}
    it { should have_many(:roles)}
  end
end