// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Tracker.Views.Home = (function(_super) {
    __extends(Home, _super);

    function Home() {
      return Home.__super__.constructor.apply(this, arguments);
    }

    Home.prototype.name = "home";

    Home.prototype.className = "page";

    Home.prototype.template = $("#tpl-home").html();

    Home.prototype.events = {};

    Home.prototype.initialize = function() {
      _.bindAll(this, "render", "navigate");
      return Tracker.Views.Page.prototype.initialize.call(this);
    };

    Home.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    return Home;

  })(Tracker.Views.Page);

}).call(this);
