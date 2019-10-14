require_relative '../automated_init'

context "Write" do
  context "Instance Has No Transform or Transformer Namespace" do
    instance = Controls::NoTransformer.example

    test "Is an error" do
      assert_raises Transform::Error do
        Write.(instance, :some_format)
      end
    end
  end
end
