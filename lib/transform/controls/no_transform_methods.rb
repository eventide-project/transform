module Transform
  module Controls
    module NoTransformMethods
      class Example
        module Transform
          def self.some_format
            SomeFormat
          end

          module SomeFormat
            def self.write(raw_data)
              Controls::Text.example
            end

            def self.read(text)
              Controls::RawData.example
            end
          end
        end
      end

      def self.example
        Example.new
      end

      def self.example_class
        Example
      end
    end
  end
end
