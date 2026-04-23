class CreateDegrees < ActiveRecord::Migration[8.1]
  def change
    create_table :degrees do |t|
      t.string :name
      t.integer :duration_years
      t.string :code
      t.string :description
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
