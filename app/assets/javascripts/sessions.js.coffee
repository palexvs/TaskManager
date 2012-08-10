jQuery ->
  $('div.navbar li.logout').hide()
  IsLogIn()

IsLogIn = ()->
  $.ajax
    type: 'get'
    url: '/sessions/'
    success: (data, xhr) -> 
      LogRegOK(data)
    error: -> LogIn()

LogIn = ()->
  $.ajax
    type: 'get'
    url: '/login'
    success: (html, xhr) -> 
      OpenModalWindow(html)
      $('#modal form.login-register')
        .on('ajax:error', (xhr, err) -> LogRegErr(err))
        .on('ajax:success', (xhr, data) -> LogRegOK(data))

LogRegOK = (data) ->
  $('div.navbar li.login').hide()
  $('div.navbar li.user_email').html("<a>#{data.email}</a>").show()
  $('div.navbar li.logout').show()
  CloseModalWindow()
  LoadProjectList()

LogRegErr= (errors) ->
  ShowErrMsg(errors)  