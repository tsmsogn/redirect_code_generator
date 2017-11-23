require "redirect_code_generator/generator/generator"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      attr_reader :old, :new, :permanent

      def initialize(old, new, permanent = true, escape = true)
        @old, @new, @permanent, @escape = old, new, permanent, escape
      end

      def create_redirect_code
        erb = ERBFactory.new('apache').get_instance
        erb.result(binding)
      end

      def uri
        @uri ||= URI.parse(@old)
      end

      def escape?
        @escape
      end
    end
  end
end
