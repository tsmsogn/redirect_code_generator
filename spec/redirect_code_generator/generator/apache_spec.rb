require "spec_helper"
require "redirect_code_generator/generator/apache"

describe RedirectCodeGenerator::Generator::Apache do
  subject(:generator) {described_class}
  let (:old_url) {'http://old.com'}
  let (:new_url) {'http://new.com'}

  describe ".new" do
    it "doesn't work without param" do
      expect {generator.new}.to raise_error
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
# 301 /old.html -> /new.html
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/?old\\\.html$ /new.html? [R=301,L]
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
# 302 /old/ -> /new/
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/?old/$ /new/? [R=302,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with no escape option" do
      old = "/old_user_dir/(.*)"
      new = "/new_user_dir/$1"
      permanent = true
      escape = false
      g = generator.new(old, new, permanent, escape)

      code = <<CODE
# 301 /old_user_dir/(.*) -> /new_user_dir/$1
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/?old_user_dir/(.*)$ /new_user_dir/$1? [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has query" do
      old = "/old/?page=1&search=word"
      new = "/new/"
      g = generator.new(old, new)

      code = <<CODE
# 301 /old/?page=1&search=word -> /new/
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{QUERY_STRING} (^|&)page=1($|&)
    RewriteCond %{QUERY_STRING} (^|&)search=word($|&)
    RewriteRule ^/?old/$ /new/? [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has host" do
      old = "http://old.com"
      new = "http://new.com"
      g = generator.new(old, new)

      code = <<CODE
# 301 http://old.com -> http://new.com
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteCond %{HTTP_HOST} ^old\\\.com$
    RewriteRule ^$ http://new.com? [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with url has port" do
      old = "http://old.com:8080"
      new = "http://new.com"
      g = generator.new(old, new)

      code = <<CODE
# 301 http://old.com:8080 -> http://new.com
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^old\\\.com$
    RewriteCond %{SERVER_PORT} 8080
    RewriteRule ^$ http://new.com? [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end

    it "works with ssl" do
      old = "https://old.com"
      new = "https://new.com"
      g = generator.new(old, new)

      code = <<CODE
# 301 https://old.com -> https://new.com
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{HTTPS} on
    RewriteCond %{HTTP_HOST} ^old\\\.com$
    RewriteRule ^$ https://new.com? [R=301,L]
</IfModule>
CODE

      expect(g.create_redirect_code).to eq(code)
    end
  end

  describe '.redirect_http_status_code' do
    context 'permanent' do
      it 'returns 301' do
        g = generator.new(old_url, new_url)

        expect(g.redirect_http_status_code).to eq(301)
      end
    end

    context 'temporary' do
      it 'returns 302' do
        g = generator.new(old_url, new_url, false)

        expect(g.redirect_http_status_code).to eq(302)
      end
    end
  end
end
