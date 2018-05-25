require_relative 'init'
require 'test_bench'; TestBench.activate

# By Default, transformers are in an inner module named "Transform"
# that implements a "call" method that accepts an instance of the
# object being transformed

class Example
  attr_accessor :some_attribute

  def ==(other)
    other.some_attribute == self.some_attribute
  end

  module Transform
    def self.some_format
      SomeFormat
    end

    def self.instance(raw_data)
      instance = Example.new
      instance.some_attribute = raw_data
      instance
    end

    def self.raw_data(instance)
      instance.some_attribute
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
