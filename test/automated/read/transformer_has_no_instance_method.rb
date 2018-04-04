require_relative '../automated_init'

context "Read" do
  context "Transformer Has No Write Method" do
    text = Controls::Text.example

    example_class = Controls::NoTransformMethods.example_class

    test "Is an error" do
      assert proc { Read.(text, example_class, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
