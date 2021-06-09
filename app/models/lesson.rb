class Lesson < ApplicationRecord
  belongs_to :chapter, class_name: "Chapter", foreign_key: "chapter_id"

  after_validation :set_slug, only: [:create, :update]
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :description, presence: true
  validates :chapter, :presence => true

  def as_json(options={})
    super(
      :methods => [:next_lesson, :previous_lesson],
      :include => {
        :chapter => {:only => [:title, :slug], :include => {:course => {:only => [:name, :slug]}}}
      } 
    )
  end

  def next_lesson
    lesson = Lesson.where('chapter_id = ?and id > ?',  self.chapter_id, self.id).first
     lesson && lesson.slug
  end

  def previous_lesson
    lesson = Lesson.where('chapter_id = ?and id < ?',  self.chapter_id, self.id).first
     lesson && lesson.slug
  end

  private
  def set_slug
    self.slug = title.to_s.parameterize
  end

end
