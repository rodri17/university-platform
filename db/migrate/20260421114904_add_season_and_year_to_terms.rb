class AddSeasonAndYearToTerms < ActiveRecord::Migration[8.1]
  def change
    add_column :terms, :season, :string
    add_column :terms, :year, :integer
  end
end
