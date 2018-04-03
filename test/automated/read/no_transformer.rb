require_relative '../automated_init'

context "Read" do
  context "Class has no transform or transformer namespace" do
    text = Controls::Text.example

    example_class = Controls::NoTransformer.example_class

    test "Is an error" do
      assert proc { Read.(text, example_class, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
