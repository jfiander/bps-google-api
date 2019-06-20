# frozen_string_literal: true

class ProgressBar
  class Silent
    def self.tty?
      true
    end

    def self.print(str)
      str
    end

    def self.flush
      self
    end
  end
end
