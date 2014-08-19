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
    
  tables: () ->
    @tables = @app.views['tables'] || new Tracker.Views.Tables()
    @app.push(@tables)
    
  play: () ->
    if(!Tracker.Instance.user.hasOwnProperty('playing'))
      Tracker.Instance.main_router.navigate('',{trigger:true})
      return false
    @play = @app.views['play'] || new Tracker.Views.Play()
    @app.push(@play)

  toggle_loader: () ->
    $(@loader_el).fadeOut()