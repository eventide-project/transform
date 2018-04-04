require_relative '../automated_init'

context "Read" do
  context "Transform Namespace" do
    text = Controls::Text.example

    [Controls::Subject::Transform, Controls::Subject::Transformer].each do |control|

      context "#{control.name}" do
        control_instance = control.example
        example_class = control_instance.class

        test "Converts text into an instance" do
          instance = Read.(text, :some_format, example_class)
          assert(instance == control_instance)
        end
      end
    end
  end
end
