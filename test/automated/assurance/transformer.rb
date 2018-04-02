require_relative '../automated_init'

context "Class has no transform or transformer namespace" do
  test "Is an error" do
    example_class = Controls::NoTransformer.example_class

    assert proc { Transform.transformer(example_class) } do
      raises_error? Transform::Error
    end
  end
end
