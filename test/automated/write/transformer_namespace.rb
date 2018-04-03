require_relative '../automated_init'

context "Write" do
  control_text = Controls::Text.example

  instance = Controls::Subject::Transformer.example

  text = Write.(instance, :some_format)

  test "Transforms an instance into text" do
    assert(text == control_text)
  end
end
