class Course < ApplicationRecord
  belongs_to :degree
  belongs_to :teacher
  belongs_to :term
  has_many :schedules, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
end
