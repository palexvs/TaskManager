# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
# Show Task
  $('#main')
    .on('ajax:error', 'a.task-show', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.task-show', (xhr, data) -> ShowTaskDetails(data))
    .on('ajax:error', 'a.task-edit', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.task-edit', (xhr, data) -> ShowTaskEdit(data))
    .on('ajax:error', 'a.task-delete', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.task-delete', (xhr, data) -> RemoveRow($(this)))    
    .on('change', 'input.task-status-chekbox', () -> SetTaskStatus($(this)))
    .on('ajax:error', 'a.task-priority', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.task-priority', (xhr, data) -> MoveRow($(this)))   
    .on('ajax:error', 'form.task-add', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'form.task-add', (xhr, data) -> AddRow($(this), data))

# Show Details
ShowTaskDetails= (html) ->
  OpenModalWindow(html)

# Remove 
RemoveRow= (object) ->
  thisRow = object.closest("tr")
  thisRow.fadeOut(500, -> thisRow.remove())

# Edit
ShowTaskEdit= (html) ->
  OpenModalWindow(html)
  $('#myModal #task_deadline').datetimepicker({minDate: new Date(), dateFormat: 'yy-mm-dd',})  
  $('#myModal form.task-add-edit')
    .on('ajax:error', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', (xhr, data) -> UpdateTask())

# Update
UpdateTask= () ->
  CloseModalWindow()
  LoadProjectList()

# Change Status
SetTaskStatus = (ch)->
  n = ch.closest("tr").attr("id").split("-")
  params = { task: {done: ch[0].checked } }
  request = $.ajax
    type: 'put'
    url: '/projects/'+n[0]+'/tasks/'+n[1]
    dataType: 'json'
    data: params
    error: (errors, status) -> HandleCommonErr(errors)
    success: -> ch.closest("tr").toggleClass('status-done')

# Change Priority
MoveRow= (object) ->
  thisRow = object.closest("tr")
  if object.hasClass('up')
    thisRow.insertBefore( thisRow.prev() )
  else
    if object.hasClass('down')
      thisRow.insertAfter( thisRow.next() )

# Add
AddRow= (object, html) ->
  thisTable = object.closest("table")
  thisTable.append(html)
  object[0].reset()