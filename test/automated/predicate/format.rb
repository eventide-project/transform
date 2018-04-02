require_relative '../automated_init'

context "Class has no transformer namespace" do
  example = Controls::NoFormat.example
  subject_constant = Transform.subject_constant(example)
  transformer = Transform.get_transformer(subject_constant)

  [Read, Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      refute(implemented)
    end
  end

  test "Format is not detected" do
    detected = Transform.format?(:some_format, transformer)
    refute(detected)
  end
end
