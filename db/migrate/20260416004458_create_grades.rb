class CreateGrades < ActiveRecord::Migration[8.1]
  def change
    create_table :grades do |t|
      t.references :submission, null: false, foreign_key: true
      t.decimal :score
      t.text :feedback

      t.timestamps
    end
  end
end
