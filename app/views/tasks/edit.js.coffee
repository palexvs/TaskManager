$('#modal').html('')
$("<%= escape_javascript(render 'tasks/edit')%>").appendTo('#modal').hide()
$('#myModal').on('hidden', -> $('#modal').html('') )
$('#myModal').modal('show')