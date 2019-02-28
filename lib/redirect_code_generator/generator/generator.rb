require "uri"
require "redirect_code_generator/erb_factory"

module RedirectCodeGenerator
  module Generator
    class Generator

      attr_reader :old, :new

      def initialize(old, new, permanent = true, escape = true)
        @old, @new, @permanent, @escape = old, new, permanent, escape
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
