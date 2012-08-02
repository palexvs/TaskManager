# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#main td.set-done input:checkbox').live('change', () -> SetTaskStatus($(this)) )

$('td.control .priority a').live('ajax:error', () -> LoadProjectList())
$('td.control .priority a').live('ajax:success', () -> MoveRow($(this)))

$('td.control a.delete').live('ajax:error', () -> LoadProjectList())
$('td.control a.delete').live('ajax:success', () -> RemoveRow($(this)))

@LogIn = ()->
  $.ajax
    type: 'get'
    url: '/sessions/'
    dataType: 'script'

LogIn()

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
  if object.hasClass('up')
    thisRow.insertBefore( thisRow.prev() )
  else
    if object.hasClass('down')
      thisRow.insertAfter( thisRow.next() )

@RemoveRow= (object) ->
  thisRow = object.parents("tr")
  thisRow.fadeOut(500, -> thisRow.remove())