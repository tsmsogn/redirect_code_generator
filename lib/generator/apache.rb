require "generator/generator"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      attr_reader :new

      def initialize(old, new, permanent = true)
        @old, @new, @permanent = old, new, permanent
      end

      def create_redirect_code
        erb = ERBFactory.new('apache').get_instance
        erb.result(binding)
      end

      def uri
        @uri ||= URI.parse(@old)
      end

      def status
        @status ||=
          if @permanent
            301
          else
            302
          end
      end
    end
  end
end
