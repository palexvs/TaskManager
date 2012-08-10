# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('a.project-add')
    .on('ajax:error', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', (xhr, data) -> OpenProjectWindow(data))

  $('#main')
    .on('ajax:error', 'a.project-delete', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.project-delete', (xhr, data) -> RemoveTable($(this)))
    .on('ajax:error', 'a.project-edit', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', 'a.project-edit', (xhr, data) -> OpenProjectWindow(data))

@LoadProjectList = ()->
  $.ajax
    type: 'get'
    url: '/projects/'
    success: (data, xhr) -> $('#main').html(data).hide().fadeIn()
    error: (errors, status) -> ShowErrMsg(errors)

# Remove Project
RemoveTable= (object) ->
  thisTable = object.closest("table")
  thisTable.fadeOut(500, -> thisTable.remove())

# Add/Edit Project
OpenProjectWindow= (html) ->
  OpenModalWindow(html)
  $('#modal form.project-add-edit')
    .on('ajax:error', (xhr, err) -> HandleCommonErr(err))
    .on('ajax:success', (xhr, data) -> AddUpdateProject())

AddUpdateProject= () ->
  CloseModalWindow()
  LoadProjectList()