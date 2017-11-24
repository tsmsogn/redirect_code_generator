require "redirect_code_generator/generator/apache"
require "redirect_code_generator/version"

module RedirectCodeGenerator
  def self.create_apache_redirect_code(old, new, permanent = true, escape = true)
    generator = Generator::Apache.new(old, new, permanent, escape)
    generator.create_redirect_code
  end
end
