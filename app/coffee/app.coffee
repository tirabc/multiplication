class App
  
  init: () ->
    @main_router = new Tracker.Routers.Main
    Backbone.history.start()
    
  user:
    playing: false
    score: 0

$('document').ready () ->
  # fastclick
  FastClick.attach(document.body)
  Tracker.Instance = new App
  Tracker.Instance.init()