require_relative '../automated_init'

context "Read" do
  text = Controls::Text.example

  control_instance = Controls::Subject::InstanceReceivesClass.example
  example_class = control_instance.class

  test "Instance receives raw data as well as class" do
    instance = Read.(text, :some_format, example_class)
    assert(instance.raw_data == text)
    assert(instance.cls == example_class)
  end
end
