class Tracker.Views.Play extends Tracker.Views.Page
	
  name: "play"
  template: $("#tpl-play").html()
  feedback_template: $("#tpl-feedback").html()
  score_template: $("#tpl-score").html()
  gamify_template: $("#tpl-gamify").html()
  events:
    "click .keyboard>.tile.number": "numberkey"
    "click .keyboard>.tile.delete": "del"
    "click .keyboard>.tile.cancel": "cancel"
    "click .correction": "correction"
    "click .feedback": "close_feedback"
    "click .gamify button": "close_gamify"
  className: "page"

  initialize: () ->
    @level_image_url = "public/data/level_"
    @level = null # used for gamify
    @score = 0
    @min = 1
    @max = 2
    @limit = 10
    @change_score(@score)
    Backbone.on('pushed:play',@reset_view,@)
    Backbone.on('preferences:change',@reset_preferences,@)
    _.bindAll(@,'render','numberkey','correction','del','cancel','close_feedback','reset','reset_view','change_score','reset_preferences','get_random','start_animation','gamify','close_gamify')
    Tracker.Views.Page.prototype.initialize.call(@)
  
  reset_preferences: (data) ->
    @min = data.min
    @max = data.max
    @render()
  
  reset_view: () ->
    $(".back").show()
    $(".score").show()
    #@start_animation()
    
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
    
  gamify: () ->
    image = @level_image_url + @score + ".jpg"
    json =
      score: @score
      image: image
    output = Mustache.to_html(@gamify_template,json)
    if($(".gamify").length)
      $(".gamify").replaceWith(output)
      $(".gamify").fadeIn("fast")
    else
      $(output).appendTo(@$el).fadeIn("fast")
      
  close_gamify: () ->
    $(".gamify").fadeOut("fast")
  
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
      @change_score(@score)
    json =
      correct: @correct
    output = Mustache.to_html(@feedback_template,json)
    if($(".feedback").length)
      $(".feedback").replaceWith(output)
      $(".feedback").fadeIn("fast")
    else
      $(output).appendTo(@$el).fadeIn("fast")
    if(@score && @score % 5 == 0)
      @gamify()

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
    #@start_animation()
    @
    
  get_random: () ->
    temp = Math.random()*(@max-@min+1)
    return parseInt(Math.floor(temp))+parseInt(@min)
  
  start_animation: () ->
    $("#runner").runner(
      startAt: 5000
      stopAt: 0
      countdown: true
      milliseconds: false
    ).on('runnerFinish', (e) =>
      @reset()
    )
    $("#runner").runner('start')
    
    
  render: () ->
    @first = parseInt(@get_random())
    @second = Math.floor(Math.random() * @limit) + 1
    json =
      "first": @first
      "second": @second
    output = Mustache.to_html(@template,json)
    @$el.html(output)
    @