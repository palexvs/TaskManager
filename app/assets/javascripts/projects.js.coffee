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

$('th.control a.delete').live('ajax:error', () -> LoadProjectList())
$('th.control a.delete').live('ajax:success', () -> RemoveTable($(this)))


jQuery ->
  LogIn()

@LogIn = ()->
  $.ajax
    type: 'get'
    url: '/sessions/'
    dataType: 'script'

@LoadProjectList = ()->
  $.ajax
    type: 'get'
    url: '/projects/'
    dataType: 'script'


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

@ShowTaskDetails= (object, xhr, html) ->
  $('#myModal').modal('hide')
  $(html).appendTo('#modal').hide()
  $('#myModal').on('hidden', -> $('#modal').html('') )
  $('#myModal').modal('show')  

@ShowTaskEdit= (object, xhr, html) ->
  $('#myModal').modal('hide')
  $(html).appendTo('#modal').hide()
  $('#myModal').on('hidden', -> $('#modal').html('') )
  $('#myModal').modal('show')
  $('#myModal #task_deadline').datetimepicker({minDate: new Date(), dateFormat: 'yy-mm-dd',})  