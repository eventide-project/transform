require_relative '../automated_init'

context "Write" do
  context "Instance Has No Transform or Transformer Namespace" do
    instance = Controls::NoTransformer.example

    test "Is an error" do
      assert proc { Write.(instance, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
