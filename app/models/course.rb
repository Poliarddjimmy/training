class Course < ApplicationRecord
    belongs_to :category, class_name: "Category", foreign_key: "category_id"
    has_many :chapters, class_name: "Chapter", foreign_key: "course_id"

    after_validation :set_slug, only: [:create, :update]

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, :presence => true


    private
    def set_slug
        self.slug = name.to_s.parameterize
    end
end 
