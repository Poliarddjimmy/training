class Course < ApplicationRecord
    belongs_to :category, class_name: "Category", foreign_key: "category_id"
    has_many :chapters, class_name: "Chapter", foreign_key: "course_id"

    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, :presence => true
end 
