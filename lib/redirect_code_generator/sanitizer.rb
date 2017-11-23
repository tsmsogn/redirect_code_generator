module RedirectCodeGenerator
  module Sanitizer
    def escape(str)
      Regexp.escape(str)
    end
  end
end
