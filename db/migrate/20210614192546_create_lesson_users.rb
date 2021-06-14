class CreateLessonUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :lesson_users do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
