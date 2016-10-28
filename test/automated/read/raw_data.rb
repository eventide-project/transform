require_relative '../automated_init'

context "Raw Data" do
  test "Convert raw data into an instance" do
    raw_data = Controls::RawData.example
    cls = Controls::Instance.example_class
    control_instance = Controls::Instance.example

    instance = Read.instance(raw_data, cls)

    assert(instance == control_instance)
  end
end
