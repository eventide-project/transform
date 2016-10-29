require_relative '../automated_init'

context "Serializer namespace has no transformer methods" do
  example = Transform::Controls::NoTransformMethods.example
  subject_const = Transform.subject_const(example)
  serializer = Transform.get_serializer(subject_const)

  [Transform::Read, Transform::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  context "Format" do
    test "Not detected" do
      format = Transform.format_accessor?(:some_format, serializer)
      assert(!format)
    end
  end

  context "Instance" do
    test "Not detected" do
      detected = Transform.intermediate?(serializer, :instance)
      assert(!detected)
    end
  end

  context "Raw Data" do
    test "Not detected" do
      detected = Transform.intermediate?(serializer, :raw_data)
      assert(!detected)
    end
  end
end
