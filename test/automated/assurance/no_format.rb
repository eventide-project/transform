require_relative '../automated_init'

context "Transformer has no format namespace" do
  test "Is an error" do
    example = Transform::Controls::NoFormat.example
    subject_const = Transform.subject_const(example)
    transformer = Transform.get_transformer(subject_const)

    assert proc { Transform.format(transformer, :some_format) } do
      raises_error? Transform::Error
    end
  end
end
