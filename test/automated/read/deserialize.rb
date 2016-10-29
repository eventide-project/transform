require_relative '../automated_init'

context "Deserialize" do
  text = Transform::Controls::Text.example

  control_instance = Transform::Controls::Instance.example
  example_class = control_instance.class

  test "Converts text into an instance" do
    instance = Transform::Read.(text, example_class, :some_format)
    assert(instance == control_instance)
  end

  test "Class and format arguments can be transposed" do
    instance = Transform::Read.(text, :some_format, example_class)
    assert(instance == control_instance)
  end
end
