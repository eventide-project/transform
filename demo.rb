require_relative 'init'
require 'test_bench'; TestBench.activate

# By Default, transformers are in an inner module named "Transform"
# that implements a "call" method that accepts an instance of the
# object being transformed

# The protocol implied by the Transform library requires that the
# transformer's namespace implements "raw_data" and "instance"
# methods that standardize the intermediate, as well as the final
# representation. The "instance" method is used when reading data
# into the the final representation, and the "raw_data" method is
# used when writing data from the final representation.

class Example
  attr_accessor :some_attribute
  attr_accessor :some_other_attribute

  module Transform
    def self.some_format
      SomeFormat
    end

    def self.instance(raw_data)
      instance = Example.new
      instance.some_attribute = raw_data[:some_attribute]
      instance.some_other_attribute = raw_data[:some_other_attribute]
      instance
    end

    def self.raw_data(instance)
      {
        some_attribute: instance.some_attribute,
        some_other_attribute: instance.some_other_attribute,
      }
    end

    module SomeFormat
      def self.write(raw_data)
        res = ''
        raw_data.each do |k, v|
          res << "#{k}=#{v}/"
        end
        res.chomp('/')
      end

      def self.read(text)
        entries = text.split('/')

        res = {}
        entries.each do |entry|
          k, v = *(entry.split('='))
          k = k.to_sym
          res[k] = v
        end

        res
      end
    end
  end
end

e = Example.new

e.some_attribute = 'some value'
e.some_other_attribute = 'some other value'

transformed = Transform::Write.(e, :some_format)

test "Object is transformed to format" do
  assert(transformed == 'some_attribute=some value/some_other_attribute=some other value')
end

example = Transform::Read.(transformed, :some_format, Example)

test "Object is transformed from format" do
  assert(example.some_attribute == 'some value')
  assert(example.some_other_attribute == 'some other value')
end

# The intermediate, raw data representation can be retrieved
# directly from the transformer, given an instance

example = Example.new

data = Transform::Write.raw_data(e)

test "Object is transformed into raw data" do
  assert(data == {:some_attribute=>"some value", :some_other_attribute=>"some other value"})
end

# An instance representation can be retrieved directly from
# the transformer, given a raw data representation

data = {:some_attribute=>"some value", :some_other_attribute=>"some other value"}

example = Transform::Read.instance(data, Example)

test "Object is transformed from raw data" do
  assert(example.some_attribute == 'some value')
  assert(example.some_other_attribute == 'some other value')
end
