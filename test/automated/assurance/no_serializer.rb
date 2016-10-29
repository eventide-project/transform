require_relative '../automated_init'

context "Class has no transformer namespace" do
  test "Is an error" do
    example = Transform::Controls::NoTransformer.example

    assert proc { Transform.serializer example } do
      raises_error? Transform::Error
    end
  end
end
