require_relative '../automated_init'

context "Write" do
  context "Transform Namespace" do
    control_text = Controls::Text.example

    [Controls::Subject::Transform, Controls::Subject::Transformer].each do |control|

      context "#{control.name}" do
        instance = Controls::Subject::Transform.example

        text = Write.(instance, :some_format)

        test "Transforms an instance into text" do
          assert(text == control_text)
        end
      end
    end
  end
end
