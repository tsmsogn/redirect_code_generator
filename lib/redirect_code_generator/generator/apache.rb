require "redirect_code_generator/generator/generator"
require "redirect_code_generator/apache_rewrite_normalize"

module RedirectCodeGenerator
  module Generator
    class Apache < Generator
      include ApacheRewriteNormalize

      def create_redirect_code
        erb = ERBFactory.new('apache').get_instance
        erb.result(binding)
      end

      def rewrite_rule_source_path
        path = old_uri.path
        if escape?
          path = escape(path)
        end

        to_rewrite_rule_path(path)
      end
    end
  end
end
