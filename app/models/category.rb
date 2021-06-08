class Category < ApplicationRecord
  has_many :courses, class_name: "Course", foreign_key: "category_id"

  validates :name, presence: true, uniqueness: true
  validates_presence_of :description
  validates :slug, presence: true, uniqueness: true
end
