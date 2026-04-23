class Student < ApplicationRecord
  belongs_to :university
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :submissions, dependent: :destroy
end
