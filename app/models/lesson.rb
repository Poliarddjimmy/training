class Lesson < ApplicationRecord
  belongs_to :chapter, class_name: "Chapter", foreign_key: "chapter_id"


  after_validation :set_slug, only: [:create, :update]
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :description, presence: true
  validates :chapter, :presence => true

  private
  def set_slug
    self.slug = title.to_s.parameterize
  end

end
