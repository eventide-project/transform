require_relative '../automated_init'

context "Write" do
  test "Transforms an instance into text" do
    control_text = Controls::Text.example

    instance = Controls::Subject.example

    text = Write.(instance, :some_format)

    assert(text == control_text)
  end
end
