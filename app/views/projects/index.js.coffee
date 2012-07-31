$('#main').html("<%= escape_javascript(render 'projects/projects') %>").hide().fadeIn()
$('#main td.set-done input:checkbox').change(()-> SetTaskStatus($(this)) )
$('td.control .priority a').bind('ajax:complete', () -> LoadProjectList())
<% if !flash[:alert].nil? %>
newAlert('error','<%= escape_javascript(flash[:alert]) %>', 'alert-area')
<% end %>