require "generator/generator"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      def initialize(old, new, permanent = true)
        @old, @new, @permanent = old, new, permanent
      end

      def create_redirect_code
      end
    end
  end
end
