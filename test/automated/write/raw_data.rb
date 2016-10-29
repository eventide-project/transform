require_relative '../automated_init'

context "Raw Data" do
  test "Can be retrieved from transformer before it's converted" do
    control_raw_data = Transform::Controls::RawData.example

    instance = Transform::Controls::Instance.example

    raw_data = Transform::Write.raw_data(instance)

    assert(raw_data == control_raw_data)
  end
end
