class ReadingSerializer
  include JSONAPI::Serializer
  attributes :time, :value
end
