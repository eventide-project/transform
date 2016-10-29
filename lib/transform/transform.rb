module Transform
  extend self

  class Error < RuntimeError; end

  def format(subject, format_name)
    transformer = transformer(subject)

    assure_format(format_name, transformer)
    get_format(format_name, transformer)
  end

  def get_format(format_name, transformer)
    transformer.send(format_name)
  end

  def transformer(subject)
    subject_const = subject_const(subject)

    assure_transformer(subject_const)
    get_transformer(subject_const)
  end

  def get_transformer(subject_const)
    subject_const.const_get(:Transformer)
  end

  def subject_const(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_transformer(subject_const)
    unless transformer_const?(subject_const)
      raise Error, "#{subject_const.name} doesn't have a `Transformer' namespace"
    end
  end

  def transformer?(subject)
    subject_const = subject_const(subject)
    transformer_const?(subject_const)
  end

  def transformer_const?(subject_const)
    subject_const.const_defined?(:Transformer)
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

  def implemented?(subject, format_name)
    subject_const = subject_const(subject)

    unless transformer_const?(subject_const)
      return false
    end

    transformer = get_transformer(subject_const)

    unless intermediate?(transformer, intermediate)
      return false
    end

    unless format_accessor?(format_name, transformer)
      return false
    end

    unless format?(format_name, transformer)
      return false
    end

    format = get_format(format_name, transformer)

    unless mode?(format, mode)
      return false
    end

    true
  end
end
