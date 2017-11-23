module RedirectCodeGenerator
  module ERBTemplates

    APACHE = <<CODE
# <% if permanent %>301<% else %>302<% end %> <%= old %> -> <%= new %>
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
<% if uri.query %>
<% uri.query.split('&').each do |param| %>
    RewriteCond %{QUERY_STRING} (^|&)<%= param %>($|&)
<% end %>
<% end %>
    RewriteRule ^<%= escape(uri.path) %>$ <%= new %>? [R=<% if permanent %>301<% else %>302<% end %>,L]
</IfModule>
CODE
    
  end
end
