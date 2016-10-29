module Transform
  class Log < ::Log
    def tag!(tags)
      tags << :transform
      tags << :library
      tags << :verbose
    end
  end
end
