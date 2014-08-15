class Tracker.Views.Play extends Tracker.Views.Page
	
  name: "play"
  template: $("#tpl-play").html()
  events:
    "click .keyboard>.tile.number": "numberkey"
    "click .keyboard>.tile.delete": "del"
    "click .keyboard>.tile.cancel": "cancel"
    "click .correction": "correction"
  className: "page"


  initialize: () ->
    _.bindAll(@,'render','numberkey','correction','del','cancel')
    #Tracker.Views.Page.prototype.initialize.call(@)
  
  del: (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    if(!@resultDiv || !@userInput)
      console.log('error no div and userinput')
      return false
    
    @userInput = @resultDiv.text()
    @userInput = parseInt(@userInput.substr(0,@userInput.length-1)) || ""
    @resultDiv.text(@userInput)
    
    
  cancel: (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    if(!@resultDiv || !@userInput)
      console.log('error no div and userinput')
      return false
    
    @resultDiv.text("")
  
  numberkey: (e) ->
    if(!@resultDiv)
      @resultDiv = $('.result')
    if(!@userInput)
      @userInput = new String
    else
      @userInput = @resultDiv.text()
    number = $(e.currentTarget).text()
    @resultDiv.text(@userInput+parseInt(number))
    @userInput = @userInput+parseInt(number)
    
  correction: (e) ->
    @userResult = parseInt(@userInput)
    console.log(@userResult)
    result = @first*@second
    if(@userResult != result)
      alert("error")
    else
      alert("ok")
    
  render: () ->
    @first = Math.floor(Math.random() * 10) + 1
    @second = Math.floor(Math.random() * 10) + 1
    json =
      "first": @first
      "second": @second
      "next": false
    output = Mustache.to_html(@template,json)
    @$el.html(output)
    @