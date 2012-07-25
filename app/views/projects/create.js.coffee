<% if @project.errors.empty? %>
  $('#myModal').modal('hide') 
  LoadProjectList()
  newAlert('success','Project "<%= escape_javascript(@project.name) %>" created successfully')
<% else %>
  newAlert('error','"<%= escape_javascript(@project.errors.full_messages.join) %>"', 'alert-area-modal')
<% end %>