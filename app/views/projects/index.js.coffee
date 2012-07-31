$('#main').html("<%= escape_javascript(render 'projects/projects') %>").hide().fadeIn()
<% if !flash[:alert].nil? %>
newAlert('error','<%= escape_javascript(flash[:alert]) %>', 'alert-area')
<% end %>