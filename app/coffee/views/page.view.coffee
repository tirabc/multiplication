class Tracker.Views.Page extends Backbone.View

  super_events:
    "click .link[data-link]": "navigate"
  
  initialize: () ->
    console.log("page init")
    #@events = $.merge(@super_events,@events)
    _.bindAll(@,'navigate')
    @
    
  navigate: (e) ->
    e.preventDefault()
    next = $(e.currentTarget).data("link")
    Tracker.Instance.main_router.navigate(next,{trigger:true})