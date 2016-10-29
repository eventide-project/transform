require_relative '../automated_init'

context "Class has no transformer namespace" do
  test "Is an error" do
    example = Controls::NoTransformer.example

    assert proc { Transform.transformer example } do
      raises_error? Transform::Error
    end
  end
end
