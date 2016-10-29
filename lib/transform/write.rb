module Transform
  module Write
    extend Transform

    def self.mode
      :write
    end

    def self.intermediate
      :raw_data
    end

    def self.call(instance, format_name)
      format = format(instance, format_name)

      raw_data = raw_data(instance)

      assure_mode(format, mode)
      format.write(raw_data)
    end

    def self.raw_data(instance)
      serializer = serializer(instance)
      assure_mode(serializer, intermediate)
      serializer.raw_data(instance)
    end
  end
end
