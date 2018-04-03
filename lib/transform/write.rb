module Transform
  module Write
    extend Transform

    def self.call(input, format_name)
      logger.trace { "Writing (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :input]) { input.pretty_inspect }

      transformer_reflection = transformer_reflection(input)

      format_reflection = transformer_reflection.get(format_name)

      raw_data = raw_data(input, transformer_reflection)

      output = format_reflection.(:write, raw_data)

      logger.info { "Wrote (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :output]) { output.pretty_inspect }

      output
    end

    def self.raw_data(instance, transformer_reflection=nil)
      logger.trace { "Transforming instance to raw data" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      if transformer_reflection.nil?
        subject_constant = Reflect.subject_constant(instance)
        transformer_name = transformer_name(subject_constant)

        if transformer_name.nil?
          raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
        end

        transformer_reflection = Reflect.(instance, transformer_name, strict: true)
      end

      transformer = transformer_reflection.constant
      raw_data = get_raw_data(transformer, instance)

      logger.debug { "Transformed to raw data" }
      logger.debug(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

      raw_data
    end

    # This is not strictly necessary since Reflection does this
    # but it provides symmetry with Read, which cannot use Reflection
    def self.get_raw_data(transformer, instance)
      assure_raw_data_method(transformer)
      transformer.raw_data(instance)
    end

    def self.assure_raw_data_method(transformer)
      unless transformer.respond_to?(:raw_data)
        raise Error, "#{transformer.name} does not implement `raw_data'"
      end
    end

    def self.logger
      @logger ||= Log.get(self)
    end
  end
end
