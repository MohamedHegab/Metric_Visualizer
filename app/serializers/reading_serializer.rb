class ReadingSerializer
  include JSONAPI::Serializer

  attribute :time do |object|
    object['time']
  end

  attribute :value do |object|
    object['value']
  end

  set_id :value_time  do |object|
    "#{object['value']} (#{object['time']})"
  end
end
