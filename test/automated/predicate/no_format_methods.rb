require_relative '../automated_init'

context "Format has no format methods" do
  example = Transform::Controls::NoFormatMethods.example
  subject_const = Transform.subject_const(example)
  transformer = Transform.get_transformer(subject_const)
  format = Transform.get_format(:some_format, transformer)

  [Transform::Read, Transform::Write].each do |cls|
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
