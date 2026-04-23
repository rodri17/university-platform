class CreateUniversities < ActiveRecord::Migration[8.1]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :country
      t.string :domain
      t.string :website

      t.timestamps
    end
  end
end
