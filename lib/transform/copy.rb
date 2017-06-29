module Transform
  module Copy
    def self.call(instance)
      raw_data = Write.raw_data(instance)

      new_instance = Read.instance(raw_data, instance.class)

      new_instance
    end

    def self.copied?(a, b)
      return false if a.equal?(b)

      unless Transform.transformer?(a) && Transform.transformer?(b)
        return false
      end

      raw_a = Write.raw_data(a)
      raw_b = Write.raw_data(b)

      raw_a == raw_b
    end
  end
end
