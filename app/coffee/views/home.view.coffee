class Tracker.Views.Home extends Tracker.Views.Page

  name: "home"
  className: "page"
  template: $("#tpl-home").html()
  events:
    "click .play": "play"
  
  initialize: () ->
    _.bindAll(@,"render","navigate")
    Tracker.Views.Page.prototype.initialize.call(@)
 
  play: () ->
    Tracker.Instance.user.playing = true
    
  render: () ->
    @$el.html(@template)
    @