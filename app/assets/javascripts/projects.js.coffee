# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@LoadProjectList = ()->
  $.ajax
    type: 'get'
    url: '/projects/'
    success: (data, xhr) -> $('#main').html(data).hide().fadeIn()
    error: (errors, status) -> ShowErrMsg(errors)

# Remove Project
$('th.control a.delete').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('th.control a.delete').live('ajax:success', (xhr, data) -> RemoveTable($(this)))

RemoveTable= (object) ->
  thisTable = object.parents("table")
  thisTable.fadeOut(500, -> thisTable.remove())

# Add/Edit Project
$('a.project-add, a.project-edit').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('a.project-add, a.project-edit').live('ajax:success', (xhr, data) -> OpenProjectWindow(data))
OpenProjectWindow= (html) ->
  OpenModalWindow(html)

$('form.project-add-edit').live('ajax:error', (xhr, err) -> HandleCommonErr(err))
$('form.project-add-edit').live('ajax:success', (xhr, data) -> AddUpdateProject())

AddUpdateProject= () ->
  CloseModalWindow()
  LoadProjectList()