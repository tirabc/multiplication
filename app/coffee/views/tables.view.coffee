class Tracker.Views.Tables extends Tracker.Views.Page

  name: "tables"
  template: $("#tpl-tables").html()
  template_table: $("#tpl-table").html()
  template_row: $("#tpl-row").html()
  className: "page"
  events: {}
  output: []

  initialize: () ->
    Backbone.on('pushed:tables',@create_tables,@)
    _.bindAll(@,'create_table','create_tables','render')
    Tracker.Views.Page.prototype.initialize.call(@)
	
  create_table: (number) ->
    partials =
      "row": $("#tpl-row").html()
    json =
      first: number
      seconds: [0..10]
    @output.push(Mustache.to_html(@template_table,json,partials))
    
    
  render: () ->
    
    #partials =
    #  "tpl-section": $("#tpl-section").html()
    #output = Mustache.to_html(@template,@website.toJSON())#,partials)
    @$el.html(@template)
    @
    
  create_tables: () ->
    @create_table(number)  for number in [0..10]
    $("#panel-tables").html(@output)