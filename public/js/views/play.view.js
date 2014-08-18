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

    Play.prototype.events = {
      "click .keyboard>.tile.number": "numberkey",
      "click .keyboard>.tile.delete": "del",
      "click .keyboard>.tile.cancel": "cancel",
      "click .correction": "correction",
      "click .overlay": "close_feedback",
      "click .close": "close_feedback",
      "click .next": "reset"
    };

    Play.prototype.className = "page";

    Play.prototype.initialize = function() {
      return _.bindAll(this, 'render', 'numberkey', 'correction', 'del', 'cancel', 'close_feedback', 'reset');
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
      var correct, json, output, result;
      this.userResult = parseInt(this.userInput);
      result = this.first * this.second;
      if (this.userResult !== result) {
        correct = false;
      } else {
        correct = true;
      }
      json = {
        correct: correct
      };
      output = Mustache.to_html(this.feedback_template, json);
      if (($(".feedback").length)) {
        return $(".feedback").replaceWith(output);
      } else {
        return this.$el.append(output);
      }
    };

    Play.prototype.close_feedback = function() {
      this.userInput = "";
      this.resultDiv.text("");
      return $(".feedback").fadeOut();
    };

    Play.prototype.reset = function() {
      this.userInput = "";
      delete this.resultDiv;
      this.render();
      return this;
    };

    Play.prototype.render = function() {
      var json, output;
      this.first = Math.floor(Math.random() * 10) + 1;
      this.second = Math.floor(Math.random() * 10) + 1;
      json = {
        "first": this.first,
        "second": this.second,
        "next": false
      };
      output = Mustache.to_html(this.template, json);
      this.$el.html(output);
      return this;
    };

    return Play;

  })(Tracker.Views.Page);

}).call(this);
