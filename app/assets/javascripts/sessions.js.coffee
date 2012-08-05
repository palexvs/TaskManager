jQuery ->
  IsLogIn()

IsLogIn = ()->
  $.ajax
    type: 'get'
    url: '/sessions/'
    success: -> LoadProjectList()
    error: -> LogIn()

LogIn = ()->
  $.ajax
    type: 'get'
    url: '/login'
    success: (html, xhr) -> OpenModalWindow(html)

$('form.login-register').live('ajax:error', (xhr, err) -> LogRegErr(err))
$('form.login-register').live('ajax:success', (xhr, data) -> LogRegOK(data))

LogRegOK = (xhr, data) ->
  CloseModalWIndow()
  LoadProjectList()

LogRegErr= (errors) ->
  ShowErrMsg(errors)  