class Course < ApplicationRecord
    include Slug
    include DefaultPicture

    belongs_to :category, class_name: "Category", foreign_key: "category_id"
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_many :chapters, class_name: "Chapter", foreign_key: "course_id"
    has_many :lessons, through: :chapters
    has_many :course_users, class_name: "CourseUser", foreign_key: "course_id"
    has_many :users, through: :course_users
    has_one :requirement, class_name: "Requirement", foreign_key: "course_id"

    after_validation :set_slug, only: [:create, :update]
    after_validation :set_picture, only: [:create]

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, :presence => true


    def as_json(options={})
        super(
            :methods => [:users_count, :lessons_count],
            :include => {
                :requirement => {:only => [:price, :content, :duration]},
                :category => {:only => [:name, :slug]},
                :chapters => {:only => [:title, :slug], :include => {:lessons => {:only => [:title, :slug]}}},
            } 
        )
    end

    def subscribed(id)
        users.where(id: id).first
    end

    def lessons_count
        lessons.count
    end

    def users_count
        users.count
    end

    def subscribed(id)
        users.where(id: id).first
    end

    private
    def set_slug
        self.slug = Slug.slug_generator(self.name)
    end

    def set_picture
        self.picture ||= DefaultPicture.picture
    end
end 
