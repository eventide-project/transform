module Transform
  module Controls
    module Subject
      module InstanceReceivesClass
        def self.example
          instance = example_class.new
          instance.some_attribute = Controls::RawData.example
          instance
        end

        def self.example_class
          Example
        end

        class Example
          attr_accessor :some_attribute

          module Transformer
            def self.some_format
              SomeFormat
            end

            def self.instance(raw_data, cls)
              Struct.new(:raw_data, :cls).new(raw_data, cls)
            end

            module SomeFormat
              def self.read(text)
                text
              end
            end
          end
        end
      end
    end
  end
end
