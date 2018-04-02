require_relative '../automated_init'

context "Format has no format methods" do
  example = Controls::NoFormatMethods.example
  subject_constant = Transform.subject_constant(example)
  transformer = Transform.get_transformer(subject_constant)
  format = Transform.get_format(:some_format, transformer)

  [Read, Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      refute(implemented)
    end
  end

  context "Write" do
    test "Not detected" do
      detected = Transform.mode?(format, :write)
      refute(detected)
    end
  end

  context "Read" do
    test "Not detected" do
      detected = Transform.mode?(format, :read)
      refute(detected)
    end
  end
end
