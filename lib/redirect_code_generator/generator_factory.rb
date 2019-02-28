require "redirect_code_generator/generator/apache"

module RedirectCodeGenerator
  class GeneratorFactory
    def self.new(klass, old, new, permanent = true, escape = true)
      return create_instance(klass, old, new, permanent, escape) if klass
      raise ArgumentError, 'must provide klass to be instantiated'
    end

    # Passes configuration options to instantiated class
    def self.create_instance(klass, old, new, permanent, escape)
      constant = RedirectCodeGenerator
      constant = constant.const_get 'Generator'
      constant = constant.const_get klass
      constant.new old, new, permanent, escape
    end
  end
end
