class Requirement < ApplicationRecord
  belongs_to :course

  validates :content, presence: true
  validates :duration, presence: true

end
