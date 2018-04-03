module Transform
  module Read
    extend Transform

    def self.call(input, format_name, cls)
      ## Backward compatibility for past inversion of these arguments
      ## Search codebase looking for uses of this, correct them, and
      ## remove this special case
      if format_name.instance_of?(Class) && cls.instance_of?(Symbol)
        cls, format_name = format_name, cls
      end

      logger.trace { "Reading (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :input]) { input.pretty_inspect }

      transformer_reflection = transformer_reflection(cls)

      format_reflection = transformer_reflection.get(format_name)

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

      transformer = transformer_reflection.constant

      unless transformer.respond_to?(:instance)
        raise Error, "#{transformer.name} does not implement `instance'"
      end

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
