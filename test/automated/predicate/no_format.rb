require_relative '../automated_init'

context "Class has no serializer namespace" do
  example = Transform::Controls::NoFormat.example
  subject_const = Transform.subject_const(example)
  serializer = Transform.get_serializer(subject_const)

  [Transform::Read, Transform::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  test "Format is not detected" do
    detected = Transform.format?(:some_format, serializer)
    assert(!detected)
  end
end
