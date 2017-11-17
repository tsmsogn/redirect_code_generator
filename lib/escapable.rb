module RedirectCodeGenerator
  module Escapable
    def escape(str)
      Regexp.escape(str)
    end
  end
end
