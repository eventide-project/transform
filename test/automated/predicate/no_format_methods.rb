require_relative '../automated_init'

context "Format has no format methods" do
  example = Controls::NoFormatMethods.example
  subject_const = Transform.subject_const(example)
  serializer = Transform.get_serializer(subject_const)
  format = Transform.get_format(:some_format, serializer)

  [Read, Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  context "Transform" do
    test "Not detected" do
      detected = Transform.mode?(format, :serialize)
      assert(!detected)
    end
  end

  context "Deserialize" do
    test "Not detected" do
      detected = Transform.mode?(format, :deserialize)
      assert(!detected)
    end
  end
end
