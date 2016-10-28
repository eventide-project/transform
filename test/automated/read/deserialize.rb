require_relative '../automated_init'

context "Deserialize" do
  text = Controls::Text.example

  control_instance = Controls::Instance.example
  example_class = control_instance.class

  test "Converts text into an instance" do
    instance = Read.(text, example_class, :some_format)
    assert(instance == control_instance)
  end

  test "Class and format arguments can be transposed" do
    instance = Read.(text, :some_format, example_class)
    assert(instance == control_instance)
  end
end
