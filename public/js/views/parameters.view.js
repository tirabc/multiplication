// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Tracker.Views.Parameters = (function(_super) {
    __extends(Parameters, _super);

    function Parameters() {
      return Parameters.__super__.constructor.apply(this, arguments);
    }

    Parameters.prototype.name = "parameters";

    Parameters.prototype.template = $("#tpl-parameters").html();

    Parameters.prototype.className = "page";

    Parameters.prototype.events = {
      "slide #slider": "set_limits"
    };

    Parameters.prototype.initialize = function() {
      Backbone.on('pushed:parameters', this.reset_view, this);
      _.bindAll(this, 'render', 'reset_view', 'start_animation', 'set_limits');
      return Tracker.Views.Page.prototype.initialize.call(this);
    };

    Parameters.prototype.reset_view = function() {
      $(".back").show();
      return this.start_animation();
    };

    Parameters.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    Parameters.prototype.set_limits = function() {
      this.min = $("#slider").val()[0];
      this.max = $("#slider").val()[1];
      $("#min-feedback").text(Math.round(this.min));
      $("#max-feedback").text(Math.round(this.max));
      return Backbone.trigger('preferences:change', {
        min: this.min,
        max: this.max
      });
    };

    Parameters.prototype.start_animation = function() {
      return $('#slider').noUiSlider({
        start: [4, 8],
        connect: true,
        range: {
          'min': [0],
          'max': [10]
        }
      });
    };

    return Parameters;

  })(Tracker.Views.Page);

}).call(this);
