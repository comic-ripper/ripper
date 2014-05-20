
$("body").keypress (event) ->
  if event.key == "Right" or event.key == "d"
    Turbolinks.visit $("a[rel=next]").attr("href")
  else if event.key == "Left" or event.key == "a"
    Turbolinks.visit $("a[rel=prev]").attr("href")
