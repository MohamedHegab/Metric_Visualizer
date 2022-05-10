class ReadingSerializer
  include JSONAPI::Serializer

  attribute :time

  attribute :value

  set_id :value_time do |object|
    "#{object.value} (#{object.time})"
  end

  def call
    serializable_hash.to_json
  end
end
