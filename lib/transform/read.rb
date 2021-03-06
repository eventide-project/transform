module Transform
  module Read
    extend Transform

    def self.call(input, format_name, cls)
      logger.trace { "Reading (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :input]) { input.pretty_inspect }

      transformer_reflection = transformer_reflection(cls)

      format_reflection = transformer_reflection.get(format_name, coerce_constant: false)

      raw_data = format_reflection.(:read, input)

      instance = instance(raw_data, cls, transformer_reflection)

      logger.info { "Read (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :output]) { instance.pretty_inspect }

      instance
    end

    def self.instance(raw_data, cls, transformer_reflection=nil)
      logger.trace { "Transforming raw data to instance" }
      logger.trace(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

      if transformer_reflection.nil?
        transformer_reflection = transformer_reflection(cls)
      end

      transformer = transformer_reflection.target

      instance = get_instance(transformer, raw_data, cls)

      logger.debug { "Transformed raw data to instance" }
      logger.debug(tags: [:data, :instance]) { instance.pretty_inspect }

      instance
    end

    def self.get_instance(transformer, raw_data, cls)
      assure_instance_method(transformer)

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

    def self.assure_instance_method(transformer)
      unless transformer.respond_to?(:instance)
        raise Error, "#{transformer.name} does not implement `instance'"
      end
    end

    def self.logger
      @logger ||= Log.get(self)
    end
  end
end
