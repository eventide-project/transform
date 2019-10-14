require_relative '../automated_init'

context "Copy" do
  context "Missing Transformer" do
    instance = Transform::Controls::NoTransformer.example

    test "Raises error" do
      assert_raises Transform::Error do
        Transform::Copy.(instance)
      end
    end
  end
end
