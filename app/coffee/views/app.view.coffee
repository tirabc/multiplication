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
  transitionend: false

  initialize: () ->
    _.bindAll(@,'render','push','navigate')
    
  push: (view) ->
    
    # debug transitions (simple replace)
    #current = view.render()
    #$(@stack_el).html(current.$el)

    # update the references to last & current views
    @previous = @current
    @current = view
    
    if @previous
      #@previous.$el.removeClass("is-visible")
      @previous.$el.addClass("left").removeClass("center")
      #@previous.$el.hide()
    
    if(@views.hasOwnProperty(@current.name))
      #@views[@current.name].$el.toggleClass("is-visible")
      @views[@current.name].$el.addClass("center").removeClass("right")
      @views[@current.name].$el.one('transitionend',(e)=>
        #@previous.$el.hide()
        #@previous.$el.remove()
        @previous.$el.addClass("right").removeClass("left")
      )
    else
      @current.render()
      @views[view.name] = view
      @current.$el.addClass("right")
      $(@stack_el).append(@current.$el)
      _.delay(()=> #hack to trigger css effect after html injection
        #@current.$el.toggleClass("is-visible")
        @current.$el.addClass("center").removeClass("right")
        @current.$el.one('transitionend',(e)=>
            #@previous.$el.hide()
            #@previous.$el.remove()
          @previous.$el.addClass("right").removeClass("left") if @previous
        )
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