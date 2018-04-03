require_relative '../automated_init'

context "Write" do
  context "Instance has no transform or transformer namespace" do
    test "Is an error" do
      instance = Controls::NoTransformer.example

      assert proc { Write.(instance, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
