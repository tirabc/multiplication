class Tracker.Views.Play extends Tracker.Views.Page
	
  name: "play"
  template: $("#tpl-play").html()
  feedback_template: $("#tpl-feedback").html()
  events:
    "click .keyboard>.tile.number": "numberkey"
    "click .keyboard>.tile.delete": "del"
    "click .keyboard>.tile.cancel": "cancel"
    "click .correction": "correction"
    "click .overlay": "close_feedback"
    "click .close": "close_feedback"
    "click .next": "reset"
  className: "page"


  initialize: () ->
    Backbone.trigger('score:init')
    _.bindAll(@,'render','numberkey','correction','del','cancel','close_feedback','reset')
    Tracker.Views.Page.prototype.initialize.call(@)
  
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
    @userInput = ""
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
    result = @first*@second
    if(@userResult != result)
      correct = false
    else
      correct = true
      Backbone.trigger('score:up')
    json =
      correct: correct
    output = Mustache.to_html(@feedback_template,json)
    if($(".feedback").length)
      $(".feedback").replaceWith(output)
      $(".feedback").fadeIn("fast")
    else
      $(output).appendTo(@$el).fadeIn("fast")

  close_feedback: () ->
    @userInput = ""
    @resultDiv.text("")
    $(".feedback").fadeOut("fast")
    
  reset: () ->
    @userInput = ""
    delete @resultDiv
    @render()
    @
    
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