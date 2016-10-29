require_relative '../automated_init'

context "Write" do
  test "Transforms an instance into text" do
    control_text = Transform::Controls::Text.example

    instance = Transform::Controls::Instance.example

    text = Transform::Write.(instance, :some_format)

    assert(text == control_text)
  end
end
