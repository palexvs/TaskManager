<% if @task.errors.empty? %>
  LoadProjectList()
  newAlert('success','Task "<%= escape_javascript(@task.name) %>" created successfully')
<% else %>
  newAlert('error','"<%= escape_javascript(@task.errors.full_messages.join) %>"', 'alert-area')
<% end %>