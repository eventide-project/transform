require_relative '../automated_init'

context "Read" do
  context "Transposed Arguments" do
    text = Controls::Text.example

    control_instance = Controls::Subject::Transform.example
    example_class = control_instance.class

    test "Class and format arguments can be transposed" do
      instance = Read.(text, :some_format, example_class)
      assert(instance == control_instance)
    end
  end
end
