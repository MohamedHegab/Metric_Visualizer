class MetricSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :readings
end
