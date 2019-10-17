require_relative '../automated_init'

context "Write" do
  context "Transformer Has No Raw Data Method" do
    instance = Controls::NoTransformMethods.example

    test "Is an error" do
      assert_raises(Transform::Error) do
        Write.(instance, :some_format)
      end
    end
  end
end
