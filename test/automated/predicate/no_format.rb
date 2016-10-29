require_relative '../automated_init'

context "Class has no transformer namespace" do
  example = Transform::Controls::NoFormat.example
  subject_const = Transform.subject_const(example)
  transformer = Transform.get_transformer(subject_const)

  [Transform::Read, Transform::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  test "Format is not detected" do
    detected = Transform.format?(:some_format, transformer)
    assert(!detected)
  end
end
