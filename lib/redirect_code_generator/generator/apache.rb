require "redirect_code_generator/generator/generator"
require "redirect_code_generator/apache_rewrite_normalize"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      include ApacheRewriteNormalize
      attr_reader :old, :new

      def initialize(old, new, permanent = true, escape = true)
        @old, @new, @permanent, @escape = old, new, permanent, escape
      end

      def create_redirect_code
        erb = ERBFactory.new('apache').get_instance
        erb.result(binding)
      end

      def old_uri
        @old_uri ||= URI.parse(@old)
      end

      def new_uri
        @new_uri ||= URI.parse(@new)
      end

      def permanent?
        @permanent
      end

      def escape?
        @escape
      end

      def redirect_http_status_code
        case permanent?
        when true then
          301
        when false then
          302
        end
      end

      def default_port?
        if old_uri.scheme == 'http' && old_uri.port == 80
          true
        elsif old_uri.scheme == 'https' && old_uri.port == 443
          true
        else
          false
        end
      end
    end
  end
end
