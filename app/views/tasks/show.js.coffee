$('#modal').html('')
$("<%= escape_javascript(render(@task))%>").appendTo('#modal').hide()
$('#myModal').on('hidden', -> $('#modal').html('') )
$('#myModal').modal('show')