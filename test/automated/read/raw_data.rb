require_relative '../automated_init'

context "Read" do
  context "Raw Data" do
    raw_data = Controls::RawData.example
    cls = Controls::Subject.example_class
    control_instance = Controls::Subject.example

    instance = Read.instance(raw_data, cls)

    test "Convert raw data into an instance" do
      assert(instance == control_instance)
    end
  end
end
