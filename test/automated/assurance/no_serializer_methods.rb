require_relative '../automated_init'

context "Serializer namespace has no serializer methods" do
  example = Transform::Controls::NoTransformMethods.example

  context "Format" do
    test "Is an Error" do
      assert proc { Transform.format(example, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end

  context "Instance" do
    _ = nil

    test "Is an Error" do
      assert proc { Transform::Read.instance(_, example) } do
        raises_error? Transform::Error
      end
    end
  end

  context "Raw Data" do
    test "Is an Error" do
      assert proc { Transform::Write.raw_data(example) } do
        raises_error? Transform::Error
      end
    end
  end
end
