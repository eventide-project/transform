require_relative '../automated_init'

context "Format has no format methods" do
  example = Controls::NoFormatMethods.example

  context "Serialize" do
    test "Is an Error" do
      assert proc { Write.(example, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end

  context "Deserialize" do
    text = Controls::Text.example

    test "Is an Error" do
      assert proc { Read.(text, example.class, :some_format) } do
        raises_error? Transform::Error
      end
    end
  end
end
