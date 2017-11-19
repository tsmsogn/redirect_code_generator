require "redirect_code_generator/generator/apache"

module RedirectCodeGenerator
  class GeneratorFactory
    def self.new(klass, options = {})
      return create_instance(klass, options) if klass
      raise ArgumentError, 'must provide klass to be instantiated'
    end

    # Passes configuration options to instantiated class
    def self.create_instance(klass, options)
      constant = RedirectCodeGenerator
      constant = constant.const_get 'Generator'
      constant = constant.const_get klass
      constant.new options
    end
  end
end
