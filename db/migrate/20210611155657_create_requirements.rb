class CreateRequirements < ActiveRecord::Migration[6.1]
  def change
    create_table :requirements do |t|
      t.string :price
      t.string :duration
      t.string :content
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
