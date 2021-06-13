class Lesson < ApplicationRecord
  belongs_to :chapter, class_name: "Chapter", foreign_key: "chapter_id"
  has_one :course, through: :chapter

  after_validation :set_slug, only: [:create, :update]
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :description, presence: true
  validates :chapter, :presence => true

  def as_json(options={})
    super(
      :methods => [:next_lesson, :previous_lesson, :next_lesson_by_chapter, :previous_lesson_by_chapter],
      :include => {
        :chapter => {:only => [:title, :slug], :include => {:course => {:only => [:name, :slug]}}},
        :course => {:only => [:name, :slug], :include => {:chapters => {:only => [:title], :include => {:lessons => {:only => [:title, :slug]}}}}}
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

  def next_lesson_by_chapter
    chapter = self.course.chapters.where("id > #{self.chapter.id}").first 
    if chapter 
      {lesson: chapter.lessons.first.slug, chapter: chapter.title}
    end  
  end

  def previous_lesson_by_chapter
    chapter = self.course.chapters.where("id < #{self.chapter.id}").first
    if chapter 
      {lesson: chapter.lessons.last.slug, chapter: chapter.title}
    end 
  end

  private
  def set_slug
    self.slug = title.to_s.parameterize
  end

end
