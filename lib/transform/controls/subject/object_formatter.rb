module Transform
  module Controls
    module Subject
      module ObjectFormatter
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

          def ==(other)
            other.some_attribute == self.some_attribute
          end

          module Transform
            def self.some_format
              SomeFormat.new
            end

            def self.instance(raw_data)
              instance = Example.new
              instance.some_attribute = raw_data
              instance
            end

            def self.raw_data(instance)
              instance.some_attribute
            end

            class SomeFormat
              def write(raw_data)
                Controls::Text.example
              end

              def read(text)
                Controls::RawData.example
              end
            end
          end
        end
      end
    end
  end
end
