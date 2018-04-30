module Transform
  extend self

  Error = Class.new(RuntimeError)

  def transformer_reflection(subject)
    subject_constant = Reflect.constant(subject)

    transformer_name = transformer_name(subject_constant)

    if transformer_name.nil?
      raise Error, "#{subject_constant.name} doesn't have a Transformer or Transform namespace"
    end

    Reflect.(subject, transformer_name, strict: true)
  end

  def transformer_name(subject_constant)
    if transform_const?(subject_constant)
      return :Transform
    elsif transformer_const?(subject_constant)
      return :Transformer
    else
      return nil
    end
  end

  def transform_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transform)
  end

  def transformer_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transformer)
  end

  def transformer?(subject)
    subject_constant = Reflect.constant(subject)
    transform_const?(subject_constant) || transformer_const?(subject_constant)
  end
end
