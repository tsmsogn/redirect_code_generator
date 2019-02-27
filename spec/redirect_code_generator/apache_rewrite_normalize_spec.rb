require "spec_helper"
require "redirect_code_generator/apache_rewrite_normalize"

describe RedirectCodeGenerator::ApacheRewriteNormalize do
  subject(:normalize) do
    described_class
  end

  it ".to_rewrite_rule_path" do
    expect(normalize.to_rewrite_rule_path('http://example.com/')).to eq '/?'
    expect(normalize.to_rewrite_rule_path('/old.html')).to eq '/?old.html'
  end
end