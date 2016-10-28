require_relative '../automated_init'

context "Implemented" do
  example = Controls::Instance.example

  [Read, Write].each do |cls|
    test "#{cls.name} implementation is detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(implemented)
    end
  end
end
