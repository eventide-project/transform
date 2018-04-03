require_relative '../automated_init'

context "Write" do
  context "Instance has no transform or transformer namespace" do
    instance = Controls::NoTransformer.example

    test "Is an error" do
      assert proc { Write.(instance, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
