class App
  
  init: () ->
    @main_router = new Tracker.Routers.Main
    Backbone.history.start()
    
  user:
    playing: false
    score: 0

$('document').ready () ->
  Tracker.Instance = new App
  Tracker.Instance.init()