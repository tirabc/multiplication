class Tracker.Views.Tables extends Tracker.Views.Page

  name: "tables"
  template: $("#tpl-tables").html()
  className: "page"
  events: {}

  initialize: () ->
    _.bindAll(@,'render')
    Tracker.Views.Page.prototype.initialize.call(@)
	
  render: () ->
    #partials =
    #  "tpl-section": $("#tpl-section").html()
    #output = Mustache.to_html(@template,@website.toJSON())#,partials)
    @$el.html(@template)
    @