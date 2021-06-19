class CreateCourseUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :course_users do |t|
      t.boolean :confirm, default: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
