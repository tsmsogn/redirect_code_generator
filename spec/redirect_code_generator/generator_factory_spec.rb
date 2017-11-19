require "spec_helper"
require "redirect_code_generator/generator_factory"
require "redirect_code_generator/generator/generator"

describe RedirectCodeGenerator::GeneratorFactory do
  subject(:factory) { described_class }

  describe ".new" do
    it "throws error if klass type is ommitted" do
      expect { factory.new nil }.to raise_error(ArgumentError)
    end

    it "instantiates a new object" do
      expect(factory.new('Generator')).to be_a RedirectCodeGenerator::Generator::Generator
    end
  end
end
