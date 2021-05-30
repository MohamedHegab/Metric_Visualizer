class Metric < ApplicationRecord
  has_many :readings

  validates_presence_of :name
end
