class Metric < ApplicationRecord
  has_many :readings, dependent: :destroy

  validates_presence_of :name
end
