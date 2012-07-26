<% if @flash.nil? or @flash.alert.empty? %>
  $('#modal').html('')
  $("<%= escape_javascript(render 'sessions/login')%>").appendTo('#modal').hide()
  $('#myModal').on('hidden', -> $('#modal').html('') )
  $('#myModal').modal({keyboard: false, show: true})
<% else %>
  newAlert('error','"<%= escape_javascript(@flash.alert) %>"', 'alert-area-modal')
<% end %>