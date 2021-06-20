class User < ApplicationRecord
    has_secure_password
    mount_uploader :avatar, AvatarUploader
    has_many :course_users, class_name: "CourseUser", foreign_key: "user_id"
    has_many :courses, through: :course_users
    has_many :lesson_users, class_name: "LessonUser", foreign_key: "user_id"
    has_many :lessons, through: :lesson_users
    has_many :role_users, class_name: "RoleUser", foreign_key: "user_id"
    has_many :roles, through: :role_users
    has_many :manageCourses, class_name: "Course", foreign_key: "user_id"
    
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
                :roles => {:only => [:name]},
                :courses => {:only => [:name, :slug]},
                :lessons => {:only => [:title, :slug]}
            } 
        )
    end

    def subscribed(slug)
        self.courses.where(slug: slug).first
    end

    def completed_by_me(slug)
        self.lessons.where(slug: slug).first
    end

    def has_role?(role)
        roles.where({ name: role}.compact).exists?
    end

    def add_role(role)
        role = Role.find_or_create_by!({ name: role}.compact)
        roles << role
    end
end
