module Transform
  module Read
    extend Transform

    def self.mode
      :read
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
      raw_data = format.read text

      instance(raw_data, cls)
    end

    def self.instance(raw_data, cls)
      transformer = transformer(cls)
      assure_mode(transformer, intermediate)

      method = transformer.method(:instance)

      instance = nil
      case method.parameters.length
      when 1
        instance = transformer.instance(raw_data)
      when 2
        instance = transformer.instance(raw_data, cls)
      end

      instance
    end
  end
end
