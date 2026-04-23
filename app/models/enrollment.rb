class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  STATUSES = %w[active dropped completed failed].freeze
  validates :status, inclusion: { in: STATUSES }
end
