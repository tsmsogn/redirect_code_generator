require 'uri'


module RedirectCodeGenerator
  module ApacheRewriteNormalize
    def to_rewrite_rule_path(path)
      path.gsub(/^\//, "/?")
    end

    def escape(str)
      Regexp.escape(str)
    end

    module_function :to_rewrite_rule_path, :escape
  end
end
