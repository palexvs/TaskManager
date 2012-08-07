# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Show Task
$('a.task-show').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('a.task-show').live('ajax:success', (xhr, data) -> ShowTaskDetails(data))

ShowTaskDetails= (html) ->
  OpenModalWindow(html)

# Edit Task
$('a.task-edit').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('a.task-edit').live('ajax:success', (xhr, data) -> ShowTaskEdit(data))

ShowTaskEdit= (html) ->
  OpenModalWindow(html)
  $('#myModal #task_deadline').datetimepicker({minDate: new Date(), dateFormat: 'yy-mm-dd',})  

$('form.task-add-edit').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('form.task-add-edit').live('ajax:success', (xhr, data) -> UpdateTask())

UpdateTask= () ->
  CloseModalWindow()
  LoadProjectList()

# Change Task Status
$('#main td.set-done input:checkbox').live('change', () -> SetTaskStatus($(this)) )

SetTaskStatus = (ch)->
  n = ch.parents("tr").attr("id").split("-")
  params = { task: {done: ch.is(":checked") } }
  request = $.ajax
    type: 'put'
    url: '/projects/'+n[0]+'/tasks/'+n[1]
    dataType: 'json'
    data: params
    error: (errors, status) -> HandleCommonErr(errors)
    success: -> ch.parents("tr").toggleClass('status-done')

# Change Task Priority
$('a.task-priority-up, a.task-priority-down').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('a.task-priority-up, a.task-priority-down').live('ajax:success', (xhr, data) -> MoveRow($(this)))

MoveRow= (object) ->
  thisRow = object.parents("tr")
  if object.hasClass('task-priority-up')
    thisRow.insertBefore( thisRow.prev() )
  else
    if object.hasClass('task-priority-down')
      thisRow.insertAfter( thisRow.next() )

# Remove Task
$('a.task-delete').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('a.task-delete').live('ajax:success', (xhr, data) -> RemoveRow($(this)))

RemoveRow= (object) ->
  thisRow = object.parents("tr")
  thisRow.fadeOut(500, -> thisRow.remove())

# Add Task
$('tr.add-new form').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('tr.add-new form').live('ajax:success', (xhr, data) -> AddRow($(this), data))

AddRow= (object, html) ->
  thisTable = object.parents("table")
  thisTable.append(html)
  object[0].reset()