require_relative '../automated_init'

context "Read" do
  context "Class Has No Transform or Transformer Namespace" do
    text = Controls::Text.example

    example_class = Controls::NoTransformer.example_class

    test "Is an error" do
      assert_raises(Transform::Error) do
        Read.(text, example_class, :some_format)
      end
    end
  end
end
