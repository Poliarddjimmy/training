require 'rails_helper'

RSpec.describe Course, type: :model do

  before(:all) do
    @category = create(:category, name: "Another")
    @course = create(:course, category: @category)
    @user = create(:user, name: "kjsfdswewdfjf", email: "ewesdr@swedd.com", username: "dfisdwewewhfiu")
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

  it "has:" do
    expect(@course).to respond_to(:lessons_count, :users_count)
    expect(@course).to respond_to(:subscribed, :as_json).with(1).argument 

    expect(@course.lessons_count).to eq(@course.lessons.count)
    expect(@course.users_count).to eq(@course.users.count)
    expect(@course.subscribed(@user.id)).to eq(@course.users.where(id: @user.id).first)
  end

  it "returns the specified value on any instance of the class" do
    allow_any_instance_of(Course).to receive(:set_slug).and_return(@course.name.to_s.parameterize)
    expect(@course.set_slug).to eq(@course.name.to_s.parameterize)
  end

  describe "Associations" do
    it { should belong_to(:category)}
    it { should have_many(:chapters)}
    it { should have_one(:requirement)}
    it { should have_many(:users)}
  end
end
