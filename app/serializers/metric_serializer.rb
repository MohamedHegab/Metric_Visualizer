class MetricSerializer
  include JSONAPI::Serializer
  attributes :name

  def call
    serializable_hash.to_json
  end
end
