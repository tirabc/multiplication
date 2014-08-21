class Tracker.Views.Parameters extends Tracker.Views.Page

  name: "parameters"
  template: $("#tpl-parameters").html()
  className: "page"
  events:
    "click .parameters-form button": "save"

  initialize: () ->
    Backbone.on('pushed:parameters',@reset_view,@)
    _.bindAll(@,'render')
    Tracker.Views.Page.prototype.initialize.call(@)
	
  save: () ->
    @min = $("#min").val()
    @max = $("#max").val()
    Backbone.trigger('preferences:change',{min: @min,max: @max})
    Tracker.Instance.main_router.navigate("home",trigger: true)
    
  reset_view: () ->
    $(".back").show()
    
  render: () ->
    #partials =
    #  "tpl-section": $("#tpl-section").html()
    #output = Mustache.to_html(@template,@website.toJSON())#,partials)
    @$el.html(@template)
    @