require "uri"
require "redirect_code_generator/erb_factory"
require "redirect_code_generator/escapable"

module RedirectCodeGenerator
  module Generator
    class Generator
      include Escapable

      def initialize(options = {})
      end
    end
  end
end
