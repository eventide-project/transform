require_relative '../automated_init'

context "Read" do
  context "Transformer Has No Write Method" do
    text = Controls::Text.example

    example_class = Controls::NoTransformMethods.example_class

    test "Is an error" do
      assert_raises(Transform::Error) do
        Read.(text, example_class, :some_format)
      end
    end
  end
end
