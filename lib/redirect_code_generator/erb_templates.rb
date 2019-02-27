module RedirectCodeGenerator
  module ERBTemplates

    APACHE = <<CODE
# <%= permanent? ? 301 : 302 %> <%= old %> -> <%= new %>
<IfModule mod_rewrite.c>
    RewriteEngine On
<% if default_port? && old_uri.scheme %>
    RewriteCond %{HTTPS} <% if old_uri.scheme == 'https'%>on<% else %>off<% end %>
<% end %>
<% if old_uri.host %>
    RewriteCond %{HTTP_HOST} ^<%= escape? ? escape(old_uri.host) : old_uri.host %>$
<% end %>
<% if !default_port? && old_uri.scheme %>
    RewriteCond %{SERVER_PORT} <%= old_uri.port %>
<% end %>
<% if old_uri.query %>
<% old_uri.query.split('&').each do |param| %>
    RewriteCond %{QUERY_STRING} (^|&)<%= param %>($|&)
<% end %>
<% end %>
    RewriteRule ^<%= escape? ? escape(old_uri.path) : old_uri.path %>$ <%= new %>? [R=<%= permanent? ? 301 : 302 %>,L]
</IfModule>
CODE
    
  end
end
