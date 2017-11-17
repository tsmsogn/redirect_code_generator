require "erb_templates"

module RedirectCodeGenerator
  class ERBFactory
    def initialize(template)
      @template = template
    end

    def get_instance
      template = get_erb_template(@template)
      ERB.new(template, nil, '<>', '_redirect_code')
    end

    private

    def get_erb_template(template)
      case template
      when 'apache'
        ERBTemplates::APACHE
      end
    end
  end
end
