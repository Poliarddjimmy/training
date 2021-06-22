class Role < ApplicationRecord
    include Slug 
    
    has_many :role_users
    has_many :users, through: :role_users

    after_validation :set_slug, only: [:create, :update]

    validates :name, presence: true, uniqueness: true

    private
    def set_slug
        self.slug = Slug.slug_generator(self.name)
    end
end
