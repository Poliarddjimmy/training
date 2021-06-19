class Chapter < ApplicationRecord
  belongs_to :course, class_name: "Course", foreign_key: "course_id"
  has_many :lessons, class_name: "Lesson", foreign_key: "chapter_id"

  after_validation :set_slug, only: [:create, :update]

  validates :title, presence: true, uniqueness: true
  validates_presence_of :description
  validates_presence_of :objective
  validates :course, :presence => true

  def as_json(options={})
    super(
      :include => {
        :lessons => {:only => [:title, :slug]},
        :course => {:only => [:name, :slug]}
      } 
    )
  end


  private
  def set_slug
    self.slug = title.to_s.parameterize
  end

end
