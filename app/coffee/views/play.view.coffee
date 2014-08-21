class Tracker.Views.Play extends Tracker.Views.Page
	
  name: "play"
  template: $("#tpl-play").html()
  feedback_template: $("#tpl-feedback").html()
  score_template: $("#tpl-score").html()
  events:
    "click .keyboard>.tile.number": "numberkey"
    "click .keyboard>.tile.delete": "del"
    "click .keyboard>.tile.cancel": "cancel"
    "click .correction": "correction"
    "click .feedback": "close_feedback"
  className: "page"

  initialize: () ->
    @score = 0
    @min = 1
    @max = 2
    @limit = 10
    @change_score(@score)
    Backbone.on('pushed:play',@reset_view,@)
    Backbone.on('preferences:change',@reset_preferences,@)
    _.bindAll(@,'render','numberkey','correction','del','cancel','close_feedback','reset','reset_view','change_score','reset_preferences','get_random')
    Tracker.Views.Page.prototype.initialize.call(@)
  
  reset_preferences: (data) ->
    @min = data.min
    @max = data.max
    @render()
  
  reset_view: () ->
    $(".back").show()
    $(".score").show()
    
  change_score: (score) ->
    tpl = @score_template
    json =
      score: @score
    output = Mustache.to_html(tpl,json)
    $('.score').replaceWith(output)
  
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
      @correct = false
    else
      @correct = true
      @score += 1
      @change_score(@score+1)
    json =
      correct: @correct
    output = Mustache.to_html(@feedback_template,json)
    if($(".feedback").length)
      $(".feedback").replaceWith(output)
      $(".feedback").fadeIn("fast")
    else
      $(output).appendTo(@$el).fadeIn("fast")

  close_feedback: () ->
    if(@correct)
      @reset()
      @correct = false
      return false
    @userInput = ""
    @resultDiv && @resultDiv.text("")
    $(".feedback").fadeOut("fast")
    
  reset: () ->
    @userInput = ""
    delete @resultDiv
    @render()
    @
    
  get_random: () ->
    temp = Math.random()*(@max-@min+1)
    return parseInt(Math.floor(temp))+parseInt(@min)
    
  render: () ->
    @first = parseInt(@get_random())
    @second = Math.floor(Math.random() * @limit) + 1
    json =
      "first": @first
      "second": @second
    output = Mustache.to_html(@template,json)
    @$el.html(output)
    @