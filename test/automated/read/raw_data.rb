require_relative '../automated_init'

context "Read" do
  context "Raw Data" do
    test "Convert raw data into an instance" do
      raw_data = Transform::Controls::RawData.example
      cls = Transform::Controls::Subject.example_class
      control_instance = Transform::Controls::Subject.example

      instance = Transform::Read.instance(raw_data, cls)

      assert(instance == control_instance)
    end
  end
end
