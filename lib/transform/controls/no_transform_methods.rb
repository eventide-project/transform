module Transform
  module Controls
    module NoTransformMethods
      class Example
        module Serializer
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
