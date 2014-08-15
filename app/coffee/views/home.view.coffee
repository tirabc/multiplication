class Tracker.Views.Home extends Tracker.Views.Page

  name: "home"
  className: "page"
  template: $("#tpl-home").html()
  events: {}
  
  initialize: () ->
    _.bindAll(@,"render","navigate")
    Tracker.Views.Page.prototype.initialize.call(@)
 
  render: () ->
    @$el.html(@template)
    @