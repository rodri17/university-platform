class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :credits
      t.references :degree, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
