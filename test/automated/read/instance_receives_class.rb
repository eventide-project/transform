require_relative '../automated_init'

context "Read" do
  text = Controls::Text.example

  control_instance = Controls::Subject::InstanceReceivesClass.example
  example_class = control_instance.class

  instance = Read.(text, :some_format, example_class)

  test "Instance of class is created" do
    assert(instance.cls == example_class)
  end

  test "Data is transformed into the instance" do
    assert(instance.raw_data == text)
  end
end
