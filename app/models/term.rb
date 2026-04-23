class Term < ApplicationRecord
  belongs_to :university
  has_many :courses, dependent: :destroy

  SEASONS = %w[Spring Summer Autumn Winter].freeze
  validates :season, inclusion: { in: SEASONS }, allow_nil: true
end