# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
    complete: -> LoadProjectList()