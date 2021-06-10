class CourseUser < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def self.verify(user, course)
    self.where('user_id =?  and course_id =? ', user, course).first
  end
end
