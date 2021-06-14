class User < ApplicationRecord
    has_secure_password
    mount_uploader :avatar, AvatarUploader
    has_many :course_users, class_name: "CourseUser", foreign_key: "user_id"
    has_many :courses, through: :course_users
    has_many :lesson_users, class_name: "LessonUser", foreign_key: "user_id"
    has_many :lessons, through: :lesson_users
    
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    def self.find_by_email_or_username(email,username)
        self.where("email = ? or username = ?", email, username).first
    end 

    def as_json(options={})
        super(
            only: [:id, :name, :email, :username, :created_at ],
            :include => {
                :courses => {:only => [:name, :slug]},
                :lessons => {:only => [:title, :slug]}
            } 
        )
    end

    def subscribed(slug)
        self.courses.where(slug: slug).first
    end

end
