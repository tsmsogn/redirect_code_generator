require "spec_helper"
require "redirect_code_generator/generator/apache"

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
    it "works with relative url" do
      old = "/old.html"
      new = "/new.html"
      g = generator.new(old, new)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{REQUEST_URI} ^/old\\\.html$
RewriteRule ^.*$ /new.html [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with temporary redirecting" do
      old = "/old/"
      new = "/new/"
      permanent = false
      g = generator.new(old, new, permanent)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{REQUEST_URI} ^/old/$
RewriteRule ^.*$ /new/ [R=302,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has query" do
      old = "/old/?page=1&search=word"
      new = "/new/"
      g = generator.new(old, new)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{REQUEST_URI} ^/old/$
RewriteCond %{QUERY_STRING} (^|&)page=1($|&)
RewriteCond %{QUERY_STRING} (^|&)search=word($|&)
RewriteRule ^.*$ /new/ [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has host" do
      old = "http://old.com"
      new = "http://new.com"
      g = generator.new(old, new)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{HTTPS} off
RewriteCond %{HTTP_HOST} ^old\\\.com$
RewriteCond %{SERVER_PORT} 80
RewriteRule ^.*$ http://new.com [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has port" do
      old = "http://old.com:8080"
      new = "http://new.com"
      g = generator.new(old, new)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{HTTPS} off
RewriteCond %{HTTP_HOST} ^old\\\.com$
RewriteCond %{SERVER_PORT} 8080
RewriteRule ^.*$ http://new.com [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with ssl" do
      old = "https://old.com"
      new = "https://new.com"
      g = generator.new(old, new)

      code = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteCond %{HTTPS} on
RewriteCond %{HTTP_HOST} ^old\\\.com$
RewriteCond %{SERVER_PORT} 443
RewriteRule ^.*$ https://new.com [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end
  end
end
