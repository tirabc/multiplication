class Tracker.Views.Play extends Tracker.Views.Page
	
  name: "play"
  template: $("#tpl-play").html()
  events:
    "click .keyboard>.tile": "numberkey"
    "click .correction": "correction"
  
  className: "page"

  initialize: () ->
    _.bindAll(@,'render','numberkey','correction')
    #Tracker.Views.Page.prototype.initialize.call(@)
    
  numberkey: (e) ->
    if(!@resultDiv)
      @resultDiv = $('.result')
    if(!@result)
      @result = ""
    else
      @result = @resultDiv.text()
    number = $(e.currentTarget).text()
    @resultDiv.text(@result+parseInt(number))
    
  correction: (e) ->
    alert('ok')
    ###@userResult = parseInt(@result)
    result = @first*@second
    if(@userResult != result)
      alert("error")
    else
      alert("ok")###
    
  render: () ->
    @first: Math.floor(Math.random() * 10) + 1
    @second: Math.floor(Math.random() * 10) + 1
    json =
      first: @first
      second: @second
      next: false
    output = Mustache.to_html(@template,json)
    @$el.html(output)
    @