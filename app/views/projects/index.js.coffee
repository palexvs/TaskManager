$('#main').html("<%= escape_javascript(render :partial => 'projects', :collection => @projects, :as => :project ) %>").hide().fadeIn()
<% if !flash[:alert].nil? %>
newAlert('error','<%= escape_javascript(flash[:alert]) %>', 'alert-area')
<% end %>