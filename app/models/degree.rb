class Degree < ApplicationRecord
  belongs_to :department
  has_many :courses, dependent: :destroy
end
