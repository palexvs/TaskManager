# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#main td.set-done input:checkbox').live('change', () -> SetTaskStatus($(this)) )

$('a.task-priority-up, a.task-priority-down').live('ajax:error', () -> LoadProjectList())
$('a.task-priority-up, a.task-priority-down').live('ajax:success', () -> MoveRow($(this)))

$('a.task-delete').live('ajax:error', () -> LoadProjectList())
$('a.task-delete').live('ajax:success', () -> RemoveRow($(this)))

$('a.task-show').live('ajax:error', () -> LoadProjectList())
$('a.task-show').live('ajax:success', (xhr, data) -> ShowTaskDetails($(this),xhr, data))

$('a.task-edit').live('ajax:error', () -> LoadProjectList())
$('a.task-edit').live('ajax:success', (xhr, data) -> ShowTaskEdit($(this),xhr, data))

$('tr.add-new form').live('ajax:error', () -> LoadProjectList())
$('tr.add-new form').live('ajax:success', (xhr, data) -> AddRow($(this),xhr, data))

$('form.project-add-edit').live('ajax:error', () -> LoadProjectList())
$('form.project-add-edit').live('ajax:success', (xhr, data) -> AddUpdateProject($(this),xhr, data))

$('form.login-register').live('ajax:error', (xhr, err) -> LogRegErr(err))
$('form.login-register').live('ajax:success', (xhr, data) -> LogRegOK(xhr, data))

$('th.control a.delete').live('ajax:error', () -> LoadProjectList())
$('th.control a.delete').live('ajax:success', () -> RemoveTable($(this)))

$('a.project-add, a.project-edit').live('ajax:error', () -> LoadProjectList())
$('a.project-add, a.project-edit').live('ajax:success', (xhr, data) -> OpenProjectWindow($(this),xhr, data))


jQuery ->
  IsLogIn()

@IsLogIn = ()->
  $.ajax
    type: 'get'
    url: '/sessions/'
    success: -> LoadProjectList()
    error: -> LogIn()

@LogIn = ()->
  $.ajax
    type: 'get'
    url: '/login'
    success: (html, xhr) -> OpenModalWindow(html)

@LogRegOK = (xhr, data) ->
  CloseModalWIndow()
  LoadProjectList()

@LogRegErr= (errors) ->
  errs = JSON.parse(errors.responseText)
  newAlert('error', err, 'alert-area-modal') for err in errs

@LoadProjectList = ()->
  $.ajax
    type: 'get'
    url: '/projects/'
    success: (data, xhr) -> $('#main').html(data).hide().fadeIn()
    error: (err, status) -> newAlert('error', err.responseText, 'alert-area')


@SetTaskStatus = (ch)->
  n = ch.parents("tr").attr("id").split("-")
  params = { task: {done: ch.is(":checked") } }
  request = $.ajax
    type: 'put'
    url: '/projects/'+n[0]+'/tasks/'+n[1]
    dataType: 'json'
    data: params
    error: -> LoadProjectList()
    success: -> ch.parents("tr").toggleClass('status-done')

@MoveRow= (object) ->
  thisRow = object.parents("tr")
  if object.hasClass('task-priority-up')
    thisRow.insertBefore( thisRow.prev() )
  else
    if object.hasClass('task-priority-down')
      thisRow.insertAfter( thisRow.next() )

@RemoveRow= (object) ->
  thisRow = object.parents("tr")
  thisRow.fadeOut(500, -> thisRow.remove())

@AddRow= (object, xhr, html) ->
  thisTable = object.parents("table")
  thisTable.append(html)
  object[0].reset()

@RemoveTable= (object) ->
  thisTable = object.parents("table")
  thisTable.fadeOut(500, -> thisTable.remove())

@AddUpdateProject= (object, xhr, html) ->
  $('#myModal').modal('hide')
  LoadProjectList()

@OpenProjectWindow= (object, xhr, html) ->
  @OpenModalWindow(html)

@ShowTaskDetails= (object, xhr, html) ->
  @OpenModalWindow(html)

@ShowTaskEdit= (object, xhr, html) ->
  @OpenModalWindow(html)
  $('#myModal #task_deadline').datetimepicker({minDate: new Date(), dateFormat: 'yy-mm-dd',})  

@OpenModalWindow= (html) ->
  $('#myModal').modal('hide')
  $(html).appendTo('#modal').hide()
  $('#myModal').on('hidden', -> $('#modal').html('') )
  $('#myModal').modal('show')

@CloseModalWIndow= () ->
  $('#myModal').modal('hide')