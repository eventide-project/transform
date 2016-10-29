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
      logger.trace { "Writing (Format Name: #{format_name.inspect})" }
      logger.trace(tags: [:data, :instance]) { instance.pretty_inspect }

      format = format(instance, format_name)

      raw_data = raw_data(instance)

      assure_mode(format, mode)

      transformed = format.write(raw_data)

      logger.info { "Wrote (Format Name: #{format_name.inspect})" }
      logger.debug(tags: [:data, :transformed]) { transformed.pretty_inspect }

      transformed
    end

    def self.raw_data(instance)
      logger.trace { "Transforming instance to raw data" }
      logger.trace(tag: [:data, :instance]) { instance.pretty_inspect }

      transformer = transformer(instance)
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
