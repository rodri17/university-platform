class CreateSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :submissions do |t|
      t.references :student, null: false, foreign_key: true
      t.references :assignment, null: false, foreign_key: true
      t.datetime :submitted_at
      t.text :content
      t.string :status, default: "submitted", null: false

      t.timestamps
    end
  end
end
