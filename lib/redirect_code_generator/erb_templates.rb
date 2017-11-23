module RedirectCodeGenerator
  module ERBTemplates

    APACHE = <<CODE
# <%= permanent? ? 301 : 302 %> <%= old %> -> <%= new %>
<IfModule mod_rewrite.c>
    RewriteEngine On
<% if default_port? && uri.scheme %>
    RewriteCond %{HTTPS} <% if uri.scheme == 'https'%>on<% else %>off<% end %>
<% end %>
<% if uri.host %>
    RewriteCond %{HTTP_HOST} ^<%= escape? ? escape(uri.host) : uri.host %>$
<% end %>
<% if !default_port? && uri.scheme %>
    RewriteCond %{SERVER_PORT} <%= uri.port %>
<% end %>
<% if uri.query %>
<% uri.query.split('&').each do |param| %>
    RewriteCond %{QUERY_STRING} (^|&)<%= param %>($|&)
<% end %>
<% end %>
    RewriteRule ^<%= escape? ? escape(uri.path) : uri.path %>$ <%= new %>? [R=<%= permanent? ? 301 : 302 %>,L]
</IfModule>
CODE
    
  end
end
