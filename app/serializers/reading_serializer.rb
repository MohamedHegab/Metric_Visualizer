class ReadingSerializer
  include JSONAPI::Serializer

  attribute :time

  attribute :value

  set_id :value_time do |object|
    "#{object.value} (#{object.time})"
  end
end
