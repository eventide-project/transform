module Transform
  module Controls
    module Subject
      Transformer = Subject
    end
  end
end
module Transform
  module Controls
    Subject = Transform::Controls::Subject::Transformer
  end
end

