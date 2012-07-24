$("<%= escape_javascript(render 'tasks/edit')%>").appendTo('#container-modal').hide()
$('#myModal').modal('toggle')
$('#myModal').on('hidden', -> $('#container-modal').html('') )