function newAlert (type, message, id) {
  var delay_ms = 2000;
  if (id == null) {
    id = "alert-area";
  }
  if( type == "error") {
    delay_ms = 6000;
  }
  $("<div class='alert-message alert alert-" + type + " fade in' data-alert><p> " + message + " </p></div>").appendTo("#"+id);
  $(".alert-message").delay(delay_ms).fadeOut("slow", function () { $(this).remove(); });
}