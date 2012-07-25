$('#modal').html('')
$("<%= escape_javascript(render(@project))%>").appendTo('#modal').hide()
$('#myModal').on('hidden', -> $('#modal').html('') )
$('#myModal').modal('show')