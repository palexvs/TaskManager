<% if @task.errors.empty? %>
  $('#myModal').modal('hide')
  LoadProjectList()
  newAlert('success','Task "<%= escape_javascript(@task.name) %>" updated successfully')
<% else %>
  newAlert('error','"<%= escape_javascript(@task.errors.full_messages.join) %>"', 'alert-area-modal')
<% end %>