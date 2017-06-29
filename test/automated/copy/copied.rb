require_relative '../automated_init'

context "Copy" do
  context "Copied Predicate" do
    context "Instances Are Identical" do
      instance = Controls::Subject.example

      other_instance = instance

      test "Returns false" do
        refute(Transform::Copy.copied?(other_instance, instance))
        refute(Transform::Copy.copied?(instance, other_instance))
      end
    end

    context "Instances Are Copies" do
      instance = Controls::Subject.example

      other_instance = Transform::Copy.(instance)

      test "Returns true" do
        assert(Transform::Copy.copied?(other_instance, instance))
        assert(Transform::Copy.copied?(instance, other_instance))
      end
    end

    context "Instances Are Not Copies" do
      instance = Controls::Subject.example

      other_instance = Controls::Subject.example
      other_instance.some_attribute = SecureRandom.hex(7)

      test "Returns false" do
        refute(Transform::Copy.copied?(other_instance, instance))
        refute(Transform::Copy.copied?(instance, other_instance))
      end
    end

    context "Instances Are Of Different Classes" do
      instance = Controls::Subject.example

      other_cls = Class.new
      other_instance = other_cls.new

      test "Returns false" do
        refute(Transform::Copy.copied?(other_instance, instance))
        refute(Transform::Copy.copied?(instance, other_instance))
      end
    end
  end
end
