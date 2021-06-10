class Course < ApplicationRecord
    belongs_to :category, class_name: "Category", foreign_key: "category_id"
    has_many :chapters, class_name: "Chapter", foreign_key: "course_id"
    has_and_belongs_to_many :users, join_table: "course_users", foreign_key: "user_id"

    after_validation :set_slug, only: [:create, :update]

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, :presence => true


    def as_json(options={})
        super(
              :include => {
                :category => {:only => [:name, :slug]},
                :chapters => {:only => [:title, :slug], :include => {:lessons => {:only => [:title, :slug]}}},
                :users => {:only => [:name, :username]}
              } 
        )
    end

    private

    def set_slug
        self.slug = name.to_s.parameterize
    end
end 
