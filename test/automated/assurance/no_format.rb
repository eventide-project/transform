require_relative '../automated_init'

context "Transformer has no format namespace" do
  test "Is an error" do
    example = Controls::NoFormat.example
    subject_const = Transform.subject_const(example)
    serializer = Transform.get_serializer(subject_const)

    assert proc { Transform.format(serializer, :some_format) } do
      raises_error? Transform::Error
    end
  end
end
