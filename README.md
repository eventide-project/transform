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

# Transformation Process

The process of transforming a class to and from data is split into two phases.

By splitting the process of transformation into two phases, the complexity of each individual phase is reduced, and additional work is avoided when implementing multiple formats.

In all cases, the format accessor is invoked (eg: `json`). The format accessor returns a module that implements the class methods `read` and `write`.

When reading:

1. The `read` method of the format module is invoked. It receives the final formatted data, converts it to the intermediate data format, and returns the intermediate data.
2. The `instance` method of the `Transform` module is invoked. It receives the intermediate data, builds an instance from it, and returns the instance.

When writing:

1. The `raw_data` method of the `Transform` module is invoked. It receives an instance of the class, converts it to the intermediate data format, and returns the intermediate data.
2. The `write` method of the format module is invoked. It receives the intermediate data, converts it to the final formatted data, and returns the final formatted data.

### Intermediary Format

The protocol for reading and writing to an intermediary format is:

```ruby
class SomeClass
  module Transform
    def self.instance(raw_data)
      # Return an instance of the class built from the raw data
    end

    def self.raw_data(instance)
      # Return raw data built from the instance
    end
  end
end
```

The `Transform` protocol within a given class will be discovered when actuating the `Transform`.

### Data Format

The protocol for reading and writing to a data format is:

```ruby
class SomeClass
  module Transform

    # A format name can be whatever you like.
    # It will be invoked as a symbol when the Transform library is actuated
    def self.format_name
      # Return a reference to the format module
    end

    module FormatModule
      def self.read(formatted_data)
        # Transform the formatted data into the intermediate data format
      end

      def self.write(intermediary_data)
        # Transform the intermediary data into the formatted data
      end
    end
  end
end
```

## Custom Formats

You're not tied to a specific format in your transformations. The initial example was JSON, but it can just as easily be CSV, YAML, or even something completely custom.

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
