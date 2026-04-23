class Department < ApplicationRecord
  belongs_to :university
  has_many :teachers, dependent: :destroy
  has_many :degrees, dependent: :destroy
end
