module Transform
  extend self

  Error = Class.new(RuntimeError)

  # EG: JSON is a "format" namespace
  def format(subject_constant, format_name)
    transformer = transformer(subject_constant)

    assure_format(format_name, transformer)
    get_format(format_name, transformer)
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

  def transformer?(subject)
    subject_constant = Reflect.subject_constant(subject)
    transformer_const?(subject_constant)
  end

  def transform_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transform)
  end

  def transformer_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transformer)
  end
end
