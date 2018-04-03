module Transform
  module Write
    extend Transform

    def self.call(instance, format_name)
      logger.trace { "Writing (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      subject_constant = subject_constant(instance)

      transformer_name = transformer_name(subject_constant)

      if transformer_name.nil?
        raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
      end

      transformer_reflection = Reflect.(instance, transformer_name, strict: true)

      raw_data = raw_data(instance, transformer_reflection)

      format_reflection = transformer_reflection.get(format_name)

      transformed = format_reflection.(:write, raw_data)

      logger.info { "Wrote (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

      transformed
    end

    def self.raw_data(instance, transformer_reflection=nil)
      logger.trace { "Transforming instance to raw data" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      if transformer_reflection.nil?
        subject_constant = subject_constant(instance)
        transformer_name = transformer_name(subject_constant)

        if transformer_name.nil?
          raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
        end

        transformer_reflection = Reflect.(instance, transformer_name, strict: true)
      end

      raw_data = transformer_reflection.(:raw_data, instance)

      logger.debug { "Transformed to raw data" }
      logger.debug(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

      raw_data
    end

    def self.logger
      @logger ||= Log.get(self)
    end
  end
end
