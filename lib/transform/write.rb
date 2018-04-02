module Transform
  module Write
    extend Transform

    def self.mode
      :write
    end

    def self.intermediate
      :raw_data
    end

    # def self.__call(instance, format_name)
    #   logger.trace { "Writing (Format Name: #{format_name.inspect})" }
    #   logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

    #   format = format(instance, format_name)

    #   raw_data = raw_data(instance)

    #   assure_mode(format, mode)

    #   transformed = format.write(raw_data)

    #   logger.info { "Wrote (Format Name: #{format_name.inspect})" }
    #   logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

    #   transformed
    # end

    # def self.___call(instance, format_name)
    #   logger.trace { "Writing (Format Name: #{format_name.inspect})" }
    #   logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

    #   subject_constant = subject_constant(instance)

    #   transformer_name = transformer_name(subject_constant)

    #   if transformer_name.nil?
    #     raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
    #   end

    #   transformer_reflection = Reflect.(instance, transformer_name, strict: true)

    #   format_reflection = transformer_reflection.get(format_name)



    #   # format = format(subject_constant, format_name)

    #   # raw_data = raw_data(instance)


    #   transformer = transformer_reflection.constant
    #   raw_data = transformer.raw_data(instance)


    #   # assure_mode(format, mode)

    #   # transformed = format.write(raw_data)

    #   format = format_reflection.constant
    #   transformed = format.write(raw_data)

    #   logger.info { "Wrote (Format Name: #{format_name.inspect})" }
    #   logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

    #   transformed
    # end

    def self.call(instance, format_name)
      logger.trace { "Writing (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      subject_constant = subject_constant(instance)

      transformer_name = transformer_name(subject_constant)

      if transformer_name.nil?
        raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
      end

      transformer_reflection = Reflect.(instance, transformer_name, strict: true)

      ## use raw data method
      raw_data = transformer_reflection.(:raw_data)

      format_reflection = transformer_reflection.get(format_name)

      transformed = format_reflection.(:write, raw_data)

      logger.info { "Wrote (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

      transformed
    end

    def self.raw_data(instance)
      logger.trace { "Transforming instance to raw data" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      subject_constant = subject_constant(instance)

      transformer = transformer(subject_constant)
      assure_mode(transformer, intermediate)

      raw_data = transformer.raw_data(instance)

      logger.debug { "Transformed to raw data" }
      logger.debug(tags: [:data, :raw_data]) { raw_data.pretty_inspect }

      raw_data
    end

    def self.logger
      @logger ||= Log.get(self)
    end
  end
end
