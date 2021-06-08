class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :slug
      t.boolean :active, :default =>  true
      t.string :picture
      t.integer :category_id

      t.timestamps
    end
  end
end
