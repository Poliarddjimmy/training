require 'rails_helper'

RSpec.describe LessonUser, type: :model do
  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:lesson)}
  end
end
