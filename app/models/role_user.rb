class RoleUser < ApplicationRecord
  belongs_to :role
  belongs_to :user

  def self.verify(user)
    self.where('user_id =? ', user).first
  end
end
