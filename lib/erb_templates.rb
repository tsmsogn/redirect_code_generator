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
<% if uri.port %>
RewriteCond %{SERVER_PORT} <%= uri.port %>
<% end %>
<% if uri.path != '' %>
RewriteCond %{REQUEST_URI} ^<%= escape(uri.path) %>$
<% end %>
<% if uri.query %>
<% uri.query.split('&').each do |param| %>
RewriteCond %{QUERY_STRING} (^|&)<%= param %>($|&)
<% end %>
<% end %>
<% if permanent %>
RewriteRule ^.*$ <%= new %> [R=301,L]
<% else %>
RewriteRule ^.*$ <%= new %> [R=302,L]
<% end %>
</IfModule>
CODE
    
  end
end
