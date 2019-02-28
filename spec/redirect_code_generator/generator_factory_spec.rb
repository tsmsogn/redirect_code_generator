require "spec_helper"
require "redirect_code_generator/generator_factory"
require "redirect_code_generator/generator/generator"

describe RedirectCodeGenerator::GeneratorFactory do
  subject(:factory) { described_class }

  describe ".new" do
    it "throws error if klass type is omitted" do
      expect { factory.new nil }.to raise_error(ArgumentError)
    end

    it "instantiates a new apache generator" do
      expect(factory.new('Apache', 'old.html', 'new.html')).to be_a RedirectCodeGenerator::Generator::Apache
    end
  end
end
