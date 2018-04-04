require_relative '../automated_init'

context "Copy" do
  context "Missing Transformer" do
    instance = Transform::Controls::NoTransformer.example

    test "Raises error" do
      assert proc { Transform::Copy.(instance) } do
        raises_error?(Transform::Error)
      end
    end
  end
end
