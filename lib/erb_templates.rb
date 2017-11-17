module RedirectCodeGenerator
  module ERBTemplates

    APACHE = <<CODE
<IfModule mod_rewrite.c>
RewriteEngine On

<% if uri.scheme %>
RewriteCond %{HTTPS} <% if uri.scheme == 'https'%>on<% else %>off<% end %>
<% end %>
<% if uri.host %>
RewriteCond %{HTTP_HOST} ^<%= escape(uri.host) %>$
<% end %>
<% if uri.path != '' %>
RewriteCond %{REQUEST_URI} ^<%= escape(uri.path) %>$
<% end %>
<% if uri.query %>
<% uri.query.split('&').each do |param| %>
RewriteCond %{QUERY_STRING} (^|&)<%= param %>($|&)
<% end %>
<% end %>
RewriteRule ^.*$ <%= new %> [R=<%= status %>,L]
</IfModule>
CODE
    
  end
end
