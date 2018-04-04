require_relative '../automated_init'

context "Write" do
  context "Raw Data" do
    control_raw_data = Controls::RawData.example

    instance = Controls::Subject::Transformer.example

    raw_data = Write.raw_data(instance)

    test "Can be retrieved from transformer before it's converted" do
      assert(raw_data == control_raw_data)
    end
  end
end
