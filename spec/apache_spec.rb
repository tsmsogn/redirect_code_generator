require "spec_helper"
require "generator/apache"

describe RedirectCodeGenerator::Generator::Apache do
  subject(:generator) { described_class }

  describe ".new" do
    it "doesn't work without param" do
      expect{ generator.new }.to raise_error
    end

    it "works" do
      old = "http://old.com"
      new = "http://new.com"
      g = generator.new(old, new)

      expect(g).not_to be_nil
    end
  end

  describe ".create_redirect_code" do
    it "works with url" do
      old = "http://old.com"
      new = "http://new.com"
      g = generator.new(old, new)

      code = <<CODE
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with temporary redirecting" do
      old = "http://old.com"
      new = "http://new.com"
      permanent = false
      g = generator.new(old, new, permanent)

      code = <<CODE
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with relative url" do
      old = "/old/"
      new = "/new/"
      g = generator.new(old, new)

      code = <<CODE
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has query" do
      old = "http://old.com/?page=1"
      new = "http://new.com/?page=1"
      g = generator.new(old, new)

      code = <<CODE
CODE

      expect(g.create_redirect_code).to eq(code)
    end
  end
end
