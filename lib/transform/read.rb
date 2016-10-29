module Transform
  module Read
    extend Transform

    def self.mode
      :read
    end

    def self.intermediate
      :instance
    end

    def self.call(raw_data, format_name, cls)
      if format_name.instance_of?(Class) && cls.instance_of?(Symbol)
        cls, format_name = format_name, cls
      end

      logger.trace { "Reading (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

      format = format(cls, format_name)

      assure_mode(format, mode)
      raw_data = format.read raw_data

      transformed = instance(raw_data, cls)

      logger.debug { "Read (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

      transformed
    end

    def self.instance(raw_data, cls)
      logger.trace { "Transforming raw data to instance" }
      logger.trace(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

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

      logger.debug { "Transformed raw data to instance" }
      logger.debug(tags: [:data, :instance]) { instance.pretty_inspect }

      instance
    end

    def self.logger
      @logger ||= Log.get(self)
    end
  end
end
