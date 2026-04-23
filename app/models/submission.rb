class Submission < ApplicationRecord
  belongs_to :student
  belongs_to :assignment
  has_one :grade, dependent: :destroy

  STATUSES = %w[submitted late graded].freeze
  validates :status, inclusion: { in: STATUSES }
end
