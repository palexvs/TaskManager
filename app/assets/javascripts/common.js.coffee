@OpenModalWindow= (html) ->
  $('#myModal').modal('hide')
  $(html).appendTo('#modal').hide()
  $('#myModal').on('hidden', -> $('#modal').html('') )
  $('#myModal').modal('show')

@CloseModalWIndow= () ->
  $('#myModal').modal('hide')

@ShowErrMsg= (errors) ->
  errs = $.parseJSON(errors.responseText)
  newAlert('error', errs)

@HandleCommonErr= (errors) ->
  ShowErrMsg(errors)
  LoadProjectList()  