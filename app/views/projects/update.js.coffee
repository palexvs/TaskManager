<% if @project.errors.empty? %>
  $('#myModal').modal('hide')
  LoadProjectList()
  newAlert('success','Task "<%= escape_javascript(@project.name) %>" updated successfully')
<% else %>
  newAlert('error','"<%= escape_javascript(@project.errors.full_messages.join) %>"', 'alert-area-modal')
<% end %>