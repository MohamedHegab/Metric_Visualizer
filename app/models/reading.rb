class Reading < ApplicationRecord
  belongs_to :metric

  validates_presence_of :time, :value
  validates_uniqueness_of :time, scope: :metric_id
end
