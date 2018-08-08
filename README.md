# transform

Common interface for object and format transformation, and transformer discovery.

## Synopsis

```ruby
require 'transform'
require 'json'

class Example
  attr_accessor :some_attribute

  module Transform
    def self.json
      PrettyJSONFormat
    end

    def self.instance(raw_data)
      instance = Example.new
      instance.some_attribute = raw_data[:some_attribute]
      instance
    end

    def self.raw_data(instance)
      { some_attribute: instance.some_attribute }
    end

    module PrettyJSONFormat
      def self.read(json)
        JSON.parse(json, symbolize_names: true)
      end

      def self.write(raw_data)
        JSON.pretty_generate(raw_data)
      end
    end
  end
end

e = Example.new
e.some_attribute = "attribute"


# Writing

transformed = Transform::Write.(e, :json)

expected = <<-JSON
{
  "some_attribute": "attribute"
}
JSON

assert transformed == expected


# Reading

instance = Transform::Read.(transformed, :json, Example)

assert instance.kind_of?(Example)
assert instance.some_attribute == "attribute"
```

The process of transforming a class to and from data is split into two phases:

1. Transform to and from an instance and an intermediary format (a hash)
2. Transform to and from data (json in this example)

It is quite common to have multiple data representations of a class. By splitting the process of transformation into two phases, we can reduce the complexity of each individual phase, as well as save ourselves work when implementing additional formats.

### Intermediary Format

The protocol for reading and writing to an intermediary format is:

```ruby
class ParentClass
  module Transform
    def self.instance(raw_data)
      # take the raw data, return an instance of the parent class
    end

    def self.raw_data(instance)
      # take the instance, return raw data
    end
  end
end
```

The `Transform` [protocol](https://en.wikipedia.org/wiki/Protocol_(object-oriented_programming)) within a given class will be discovered when actuating the `Transform` library (`Transform::Write.(e, :json)`).

### Data Format

The protocol for reading and writing to a data format is:

```ruby
class ParentClass
  module Transform

    # A format name can be whatever you like.
    # It will be invoked as a symbol when the Transform library is actuated
    def self.format_name
      # return a reference to the format module
    end

    module FormatModule
      def self.read(formatted_data)
        # take the formatted data, return intermediary data
      end

      def self.write(intermediary_data)
        # take intermediary data, return formatted data
      end
    end
  end
end
```

## Custom Formats

A major advantage to this approach is that you are not tied to a specific format in your transformations. The initial example was JSON, but it can just as easily be CSV, YAML, or even something completely custom.

```ruby
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
```

## License

The `transform` library is released under the [MIT License](https://github.com/eventide-project/transform/blob/master/MIT-License.txt).
