class Lesson < ApplicationRecord
  belongs_to :chapter, class_name: "Chapter", foreign_key: "chapter_id"

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :content, presence: true
  validates :description, presence: true
  validates :chapter, :presence => true
end
