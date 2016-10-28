require_relative '../automated_init'

context "Deserialize" do
  text = Serialize::Controls::Text.example

  control_instance = Serialize::Controls::Instance.example
  example_class = control_instance.class

  test "Converts text into an instance" do
    instance = Serialize::Read.(text, example_class, :some_format)
    assert(instance == control_instance)
  end

  test "Class and format arguments can be transposed" do
    instance = Serialize::Read.(text, :some_format, example_class)
    assert(instance == control_instance)
  end
end
