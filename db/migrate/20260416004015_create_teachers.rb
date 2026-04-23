class CreateTeachers < ActiveRecord::Migration[8.1]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
