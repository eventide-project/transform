module Transform
  module Controls
    module NoTransformer
      class Example
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
