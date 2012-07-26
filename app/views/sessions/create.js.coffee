<% if signed_in? %>
  $('#myModal').modal('hide')
  LoadProjectList()
  newAlert('success','Loged In successfully')
<% else %>
  newAlert('error','Wrong email or password', 'alert-area-modal')
<% end %>