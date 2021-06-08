class Chapter < ApplicationRecord
  belongs_to :course, class_name: "Course", foreign_key: "course_id"
  has_many :lessons, class_name: "Lesson", foreign_key: "chapter_id"

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates_presence_of :description
  validates_presence_of :objective
  validates :course, :presence => true
end
