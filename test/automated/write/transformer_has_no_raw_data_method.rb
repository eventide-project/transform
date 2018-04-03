require_relative '../automated_init'

context "Write" do
  context "Transformer Has No Raw Data Method" do
    instance = Controls::NoTransformMethods.example

    test "Is an error" do
      assert proc { Write.(instance, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
