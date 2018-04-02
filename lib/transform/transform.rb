module Transform
  extend self

  Error = Class.new(RuntimeError)

  # EG: JSON is a "format" namespace
  def format(subject_constant, format_name)
    transformer = transformer(subject_constant)

    assure_format(format_name, transformer)
    get_format(format_name, transformer)
  end

  def get_format(format_name, transformer)
    transformer.send(format_name)
  end

  def __transformer(subject)
    subject_constant = subject_constant(subject)
    assure_transformer(subject_constant)
    get_transformer(subject_constant)
  end

  ## New one always works off subj const
  def transformer(subject_constant)
    ## subject_constant = subject_constant(subject)
    assure_transformer(subject_constant)
    get_transformer(subject_constant)
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

  def get_transformer(subject_constant)
    # if transformer_const?(subject_constant)
    #   return subject_constant.const_get(:Transformer)
    # elsif transform_const?(subject_constant)
    #   return subject_constant.const_get(:Transform)
    # end
    if transform_const?(subject_constant)
      return subject_constant.const_get(:Transform)
    elsif transformer_const?(subject_constant)
      return subject_constant.const_get(:Transformer)
    end
  end

  def subject_constant(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_transformer(subject_constant)
    return if transform_const?(subject_constant) || transformer_const?(subject_constant)
    raise Error, "#{subject_constant.name} doesn't have a `Transformer' or 'Transform' namespace"
  end

  def transformer?(subject)
    subject_constant = subject_constant(subject)
    transformer_const?(subject_constant)
  end

  def transform_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transform)
  end

  def transformer_const?(subject_constant)
    Reflect.constant?(subject_constant, :Transformer)
  end

  def assure_format(format_name, transformer)
    unless format_accessor?(format_name, transformer)
      raise Error, "#{transformer.name} does not implement `#{format_name}'"
    end
  end

  def format_accessor?(format_name, transformer)
    transformer.respond_to?(format_name)
  end

  def format?(format_name, transformer)
    format = get_format(format_name, transformer)
    !!format
  end

  def assure_mode(format, mode)
    unless mode?(format, mode)
      raise Error, "#{format.name} does not implement `#{mode}'"
    end
  end

  def mode?(format, mode)
    format.respond_to?(mode)
  end

  def intermediate?(transformer, intermediate_name)
    transformer.respond_to?(intermediate_name)
  end
end
