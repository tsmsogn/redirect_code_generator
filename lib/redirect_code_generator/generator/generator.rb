require "uri"
require "redirect_code_generator/erb_factory"
require "redirect_code_generator/sanitizer"

module RedirectCodeGenerator
  module Generator
    class Generator
      include Sanitizer

      def initialize(options = {})
      end
    end
  end
end
