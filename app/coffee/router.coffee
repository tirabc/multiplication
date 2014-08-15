class Tracker.Routers.Main extends Backbone.Router
  
  routes:
    "home": "home"
    "tables": "tables"
    "play": "play"
    "*page": "home"
  main_el: "#main"
  loader_el: "#loader"
  
  initialize: () ->
    @app = new Tracker.Views.App()
    @app_view = @app.render()
    @toggle_loader()
    @
  
  home: () ->
    @home = @app.views['home'] || new Tracker.Views.Home()
    @app.push(@home)
    #@home = new Tracker.Views.Home()
    #@home_view = @home.render()
    #@toggle_loader()
    
  tables: () ->
    @tables = @app.views['tables'] || new Tracker.Views.Tables()
    @app.push(@tables)
    #@history = new Tracker.Views.History()
    #@history_view = @history.render()
    #@toggle_loader()
    
  play: () ->
    @play = @app.views['play'] || new Tracker.Views.Play()
    @app.push(@play)

  toggle_loader: () ->
    $(@loader_el).fadeOut()