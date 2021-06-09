class User < ApplicationRecord
    has_secure_password
    mount_uploader :avatar, AvatarUploader
    
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
            :methods => [:id, :name, :email, :username, :created_at],
            :include => {
                # :category => {:only => [:name, :slug]},
            } 
        )
    end

end
