require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:course)}
  end
end


