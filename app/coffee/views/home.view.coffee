class Tracker.Views.Home extends Tracker.Views.Page

  name: "home"
  className: "page"
  template: $("#tpl-home").html()
  events:
    "click .play": "play"
  
  initialize: () ->
    Backbone.on("pushed:home",@reset_view,@)
    _.bindAll(@,"render","navigate")
    Tracker.Views.Page.prototype.initialize.call(@)
 
  reset_view: () ->
    $(".back").hide()
    $(".score").hide()
    
  play: () ->
    Tracker.Instance.user.playing = true
    
  render: () ->
    @$el.html(@template)
    @