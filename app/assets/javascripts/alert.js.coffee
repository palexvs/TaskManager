@newAlert= (type, messages, id) ->
  if messages?
    unless id?
      if $('#myModal').length and $('#myModal').is(':visible')
        id = "alert-area-modal"
      else
        id = "alert-area"

    delay_ms = if type == "error" then 4000 else 2000

    for message in messages
      if message?
        alert = $("<div class='alert-message alert alert-#{type} fade in' data-alert><p>#{message}</p></div>")
        alert.appendTo("##{id}")
        alert.delay(delay_ms).fadeOut("slow", () -> $(this).remove() )