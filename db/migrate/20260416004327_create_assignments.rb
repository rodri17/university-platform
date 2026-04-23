class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :max_points
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
