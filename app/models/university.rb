class University < ApplicationRecord
  has_many :departments, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_many :students, dependent: :destroy
end
