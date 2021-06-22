class LessonUser < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  def self.verify(user, lesson)
    where('user_id =?  and lesson_id =? ', user, lesson).first
  end
end
