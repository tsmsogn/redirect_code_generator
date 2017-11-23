require "redirect_code_generator/generator/generator"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      attr_reader :old, :new

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

      def permanent?
        @permanent
      end

      def escape?
        @escape
      end

      def default_port?
        if uri.scheme == 'http' && uri.port == 80
          true
        elsif uri.scheme == 'https' && uri.port == 443
          true
        else
          false
        end
      end
    end
  end
end
