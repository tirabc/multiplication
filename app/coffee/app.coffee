class App
  
  init: () ->
    @main_router = new Tracker.Routers.Main
    Backbone.history.start()

$('document').ready () ->
  Tracker.Instance = new App
  Tracker.Instance.init()