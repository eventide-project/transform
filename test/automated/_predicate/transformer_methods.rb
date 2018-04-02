require_relative '../automated_init'

context "Transformer namespace has no transformer methods" do
  example = Controls::NoTransformMethods.example
  subject_constant = Transform.subject_constant(example)
  transformer = Transform.get_transformer(subject_constant)

  [Read, Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      refute(implemented)
    end
  end

  context "Format" do
    test "Not detected" do
      format = Transform.format_accessor?(:some_format, transformer)
      refute(format)
    end
  end

  context "Instance" do
    test "Not detected" do
      detected = Transform.intermediate?(transformer, :instance)
      refute(detected)
    end
  end

  context "Raw Data" do
    test "Not detected" do
      detected = Transform.intermediate?(transformer, :raw_data)
      refute(detected)
    end
  end
end
