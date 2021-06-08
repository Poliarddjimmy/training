class Category < ApplicationRecord
  has_many :courses, class_name: "Course", foreign_key: "category_id"

  after_validation :set_slug, only: [:create, :update]

  validates :name, presence: true, uniqueness: true
  validates_presence_of :description

  private
  def set_slug
    self.slug = name.to_s.parameterize
  end
end
