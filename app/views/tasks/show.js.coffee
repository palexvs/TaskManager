$("<%= escape_javascript(render(@task))%>").appendTo('#container-modal').hide()
$('#myModal').modal('toggle')
$('#myModal').on('hidden', -> $('#container-modal').html('') )