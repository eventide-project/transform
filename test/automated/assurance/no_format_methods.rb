require_relative '../automated_init'

context "Format has no format methods" do
  example = Transform::Controls::NoFormatMethods.example

  context "Serialize" do
    test "Is an Error" do
      assert proc { Transform::Write.(example, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end

  context "Deserialize" do
    text = Transform::Controls::Text.example

    test "Is an Error" do
      assert proc { Transform::Read.(text, example.class, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
