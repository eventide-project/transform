require_relative '../automated_init'

context "Copy" do
  instance = Controls::Subject.example

  copied_instance = Transform::Copy.(instance)

  test "New instance is returned" do
    refute(copied_instance.equal?(instance))
  end

  test "Original instance and copied instance contain identical data" do
    instance_raw_data = Transform::Write.raw_data(instance)
    copied_raw_data = Transform::Write.raw_data(copied_instance)

    assert(copied_raw_data == instance_raw_data)
  end
end
