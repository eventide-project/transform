require_relative '../automated_init'

context "Class has no serializer namespace" do
  example = Transform::Controls::NoSerializer.example

  [Transform::Read, Transform::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  test "Transformer is not detected" do
    detected = Transform.serializer?(example)
    assert(!detected)
  end
end
