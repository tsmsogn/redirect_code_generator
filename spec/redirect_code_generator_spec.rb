require "spec_helper"

describe RedirectCodeGenerator do
  it "has a version number" do
    expect(RedirectCodeGenerator::VERSION).not_to be nil
  end

  it ".create_apache_redirect_code" do
    code = <<CODE
# 301 /old.html -> /new.html
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/old\\\.html$ /new.html? [R=301,L]
</IfModule>
CODE

    old = "/old.html"
    new = "/new.html"
    expect(RedirectCodeGenerator.create_apache_redirect_code(old, new)).to eq code
  end
end
