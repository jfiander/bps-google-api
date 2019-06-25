# frozen_string_literal: true

class GoogleAPI
  class Config
    attr_accessor :root
    attr_writer :keys

    def initialize
      self.root = __dir__

      yield self if block_given?
    end

    def keys
      @keys || root
    end

    def local_path(*path)
      basepath = block_given? ? yield(self) : root
      fullpath = File.join(basepath, *path)
      paths = fullpath.split('/')
      filename = paths.pop
      path = File.join(*paths)

      FileUtils.mkdir_p(path)
      File.join(path, filename)
    end
  end
end
