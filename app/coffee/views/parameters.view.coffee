class Tracker.Views.Parameters extends Tracker.Views.Page

  name: "parameters"
  template: $("#tpl-parameters").html()
  className: "page"
  events:
    "slide #slider": "set_limits"

  initialize: () ->
    Backbone.on('pushed:parameters',@reset_view,@)
    _.bindAll(@,'render','reset_view','start_animation','set_limits')
    Tracker.Views.Page.prototype.initialize.call(@)
	
  reset_view: () ->
    $(".back").show()
    @start_animation()
    
  render: () ->
    #partials =
    #  "tpl-section": $("#tpl-section").html()
    #output = Mustache.to_html(@template,@website.toJSON())#,partials)
    @$el.html(@template)
    @
  
  set_limits: () ->
    @min = $("#slider").val()[0]
    @max = $("#slider").val()[1]
    $("#min-feedback").text(Math.round(@min))
    $("#max-feedback").text(Math.round(@max))
    Backbone.trigger('preferences:change',{min: @min,max: @max})
    #Tracker.Instance.main_router.navigate("home",trigger: true)
  
  start_animation: () ->
    $('#slider').noUiSlider(
      start: [ 4, 8 ]
      connect: true
      range:
        'min': [0]
        'max': [10]
    )