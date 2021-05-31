class MetricSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :readings, if: proc { |_record, params| params && params[:include].include?('readings') }
end
