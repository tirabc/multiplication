// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Tracker.Views.Play = (function(_super) {
    __extends(Play, _super);

    function Play() {
      return Play.__super__.constructor.apply(this, arguments);
    }

    Play.prototype.name = "play";

    Play.prototype.template = $("#tpl-play").html();

    Play.prototype.feedback_template = $("#tpl-feedback").html();

    Play.prototype.score_template = $("#tpl-score").html();

    Play.prototype.events = {
      "click .keyboard>.tile.number": "numberkey",
      "click .keyboard>.tile.delete": "del",
      "click .keyboard>.tile.cancel": "cancel",
      "click .correction": "correction",
      "click .feedback": "close_feedback"
    };

    Play.prototype.className = "page";

    Play.prototype.initialize = function() {
      this.score = 0;
      this.min = 1;
      this.max = 2;
      this.limit = 10;
      this.change_score(this.score);
      Backbone.on('pushed:play', this.reset_view, this);
      Backbone.on('preferences:change', this.reset_preferences, this);
      _.bindAll(this, 'render', 'numberkey', 'correction', 'del', 'cancel', 'close_feedback', 'reset', 'reset_view', 'change_score', 'reset_preferences', 'get_random');
      return Tracker.Views.Page.prototype.initialize.call(this);
    };

    Play.prototype.reset_preferences = function(data) {
      this.min = data.min;
      this.max = data.max;
      return this.render();
    };

    Play.prototype.reset_view = function() {
      $(".back").show();
      return $(".score").show();
    };

    Play.prototype.change_score = function(score) {
      var json, output, tpl;
      tpl = this.score_template;
      json = {
        score: this.score
      };
      output = Mustache.to_html(tpl, json);
      return $('.score').replaceWith(output);
    };

    Play.prototype.del = function(e) {
      e.preventDefault();
      e.stopPropagation();
      if (!this.resultDiv || !this.userInput) {
        console.log('error no div and userinput');
        return false;
      }
      this.userInput = this.resultDiv.text();
      this.userInput = parseInt(this.userInput.substr(0, this.userInput.length - 1)) || "";
      return this.resultDiv.text(this.userInput);
    };

    Play.prototype.cancel = function(e) {
      e.preventDefault();
      e.stopPropagation();
      if (!this.resultDiv || !this.userInput) {
        console.log('error no div and userinput');
        return false;
      }
      this.userInput = "";
      return this.resultDiv.text("");
    };

    Play.prototype.numberkey = function(e) {
      var number;
      if (!this.resultDiv) {
        this.resultDiv = $('.result');
      }
      if (!this.userInput) {
        this.userInput = new String;
      } else {
        this.userInput = this.resultDiv.text();
      }
      number = $(e.currentTarget).text();
      this.resultDiv.text(this.userInput + parseInt(number));
      return this.userInput = this.userInput + parseInt(number);
    };

    Play.prototype.correction = function(e) {
      var json, output, result;
      this.userResult = parseInt(this.userInput);
      result = this.first * this.second;
      if (this.userResult !== result) {
        this.correct = false;
      } else {
        this.correct = true;
        this.score += 1;
        this.change_score(this.score + 1);
      }
      json = {
        correct: this.correct
      };
      output = Mustache.to_html(this.feedback_template, json);
      if (($(".feedback").length)) {
        $(".feedback").replaceWith(output);
        return $(".feedback").fadeIn("fast");
      } else {
        return $(output).appendTo(this.$el).fadeIn("fast");
      }
    };

    Play.prototype.close_feedback = function() {
      if (this.correct) {
        this.reset();
        this.correct = false;
        return false;
      }
      this.userInput = "";
      this.resultDiv && this.resultDiv.text("");
      return $(".feedback").fadeOut("fast");
    };

    Play.prototype.reset = function() {
      this.userInput = "";
      delete this.resultDiv;
      this.render();
      return this;
    };

    Play.prototype.get_random = function() {
      var temp;
      temp = Math.random() * (this.max - this.min + 1);
      return parseInt(Math.floor(temp)) + parseInt(this.min);
    };

    Play.prototype.render = function() {
      var json, output;
      this.first = parseInt(this.get_random());
      this.second = Math.floor(Math.random() * this.limit) + 1;
      json = {
        "first": this.first,
        "second": this.second
      };
      output = Mustache.to_html(this.template, json);
      this.$el.html(output);
      return this;
    };

    return Play;

  })(Tracker.Views.Page);

}).call(this);
