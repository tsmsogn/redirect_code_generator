module RedirectCodeGenerator
  module ERBTemplates

    APACHE = <<CODE
# <%= redirect_http_status_code %> <%= old %> -> <%= new %>
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
    RewriteRule ^<%= rewrite_rule_source_path %>$ <%= new %>? [R=<%= redirect_http_status_code %>,L]
</IfModule>
CODE
    
  end
end
