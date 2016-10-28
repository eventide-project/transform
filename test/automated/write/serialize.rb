require_relative '../automated_init'

context "Transform" do
  test "Transforms an instance into text" do
    control_text = Controls::Text.example

    instance = Controls::Instance.example

    text = Write.(instance, :some_format)

    assert(text == control_text)
  end
end
