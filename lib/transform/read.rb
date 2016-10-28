module Transform
  module Read
    extend Transform

    def self.mode
      :deserialize
    end

    def self.intermediate
      :instance
    end

    def self.call(text, format_name, cls)
      if format_name.instance_of?(Class) && cls.instance_of?(Symbol)
        cls, format_name = format_name, cls
      end

      format = format(cls, format_name)

      assure_mode(format, mode)
      raw_data = format.deserialize text

      instance(raw_data, cls)
    end

    def self.instance(raw_data, cls)
      serializer = serializer(cls)
      assure_mode(serializer, intermediate)
      serializer.instance(raw_data)
    end
  end
end
