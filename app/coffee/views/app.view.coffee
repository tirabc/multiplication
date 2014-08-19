class Tracker.Views.App extends Backbone.View
	
  el: "#main"
  template: $("#tpl-app").html()
  page_el: "#page"
  events:
    "click .link[data-link]": "navigate"
  views: {}
  previous: null
  current: null
  stack_el: "#stack"

  initialize: () ->
    Backbone.on('score:up',@increase,@)
    Backbone.on('score:init',@scoreInit,@)
    _.bindAll(@,'render','push','navigate','increase','changeScore','scoreInit')
    
  scoreInit: () ->
    @score = 0
    @changeScore()
  
  changeScore: () ->
    $('.score').text(@score)
    
  increase: () ->
    @score++
    @changeScore()
    
  push: (view) ->
    # update the references to last & current views
    @previous = @current
    @current = view
    
    if @previous
      @previous.$el.removeClass("is-visible")
    
    if(@views.hasOwnProperty(@current.name))
      @views[@current.name].$el.toggleClass("is-visible")
    else
      @current.render()
      @views[view.name] = view
      $(@stack_el).append(@current.$el)
      _.delay(()=> #hack to trigger css effect after html injection
        @current.$el.toggleClass("is-visible")
      ,20)
    
    # log & fire pushed event
    Backbone.trigger(@current.name + ":page-pushed")
    #if(@previous && @previous.hasOwnProperty("closed"))
    #  @previous.closed.call(@)

  navigate: (e) ->
    e.preventDefault()
    next = $(e.currentTarget).data("link")
    Tracker.Instance.main_router.navigate(next,{trigger:true})
    
  render: () ->
    @$el.html(@template)
    @