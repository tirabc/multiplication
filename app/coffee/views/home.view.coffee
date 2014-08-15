class Tracker.Views.Home extends Tracker.Views.Page

  name: "home"
  className: "page"
  template: $("#tpl-home").html()
  events: {}
  
  initialize: () ->
    ###
    @data = {}
    @runs = new Tracker.Collections.Runs()
    @runs.fetch().done( (data) =>
      console.log data
      @data = @runs.formatAeraData()
    )
    ###
    _.bindAll(@,"render","navigate")
    Tracker.Views.Page.prototype.initialize.call(@)
  ###
  alert: () ->
    alert('ok')
    
  save: () ->
    run = new Tracker.Models.Run()
    run.set('time',$("#field-time input").val())
    run.set('distance',$("#field-distance input").val())
    run.set('date',new Date())
    console.log(run)
    @runs.create(run)
  ###
  render: () ->
    @$el.html(@template)
    #@showCharts()
    @
  ###
  showCharts: () ->
    Morris.Area(
      element: 'myfirstchart'
      data: @data
      xkey: 'date'
      ykeys: ['time', 'distance']
      labels: ['Time', 'Distance']
      gridTextColor: "#FFF"
      hideHover: true
    )
    @
  ###
