class Teacher < ApplicationRecord
  belongs_to :department
  has_many :courses, dependent: :nullify
end
