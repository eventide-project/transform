require_relative '../automated_init'

context "Transformer has no format namespace" do
  test "Is an error" do
    example = Controls::NoFormat.example
    subject_constant = Transform.subject_constant(example)
    transformer = Transform.get_transformer(subject_constant)

    assert proc { Transform.format(transformer, :some_format) } do
      raises_error? Transform::Error
    end
  end
end
