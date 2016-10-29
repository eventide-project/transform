require_relative '../automated_init'

context "Implemented" do
  example = Transform::Controls::Subject.example

  [Transform::Read, Transform::Write].each do |cls|
    test "#{cls.name} implementation is detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(implemented)
    end
  end
end
