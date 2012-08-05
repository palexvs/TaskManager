<% if @user.errors.empty? %>
  $('#myModal').modal('hide')
  LoadProjectList()
  newAlert('success','User "<%= escape_javascript(@user.email) %>" created successfully')
<% else %>
  newAlert('error','<%= escape_javascript(@user.errors.full_messages.join) %>')
<% end %>