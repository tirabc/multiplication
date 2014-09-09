// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Tracker.Views.App = (function(_super) {
    __extends(App, _super);

    function App() {
      return App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.el = "#main";

    App.prototype.template = $("#tpl-app").html();

    App.prototype.page_el = "#page";

    App.prototype.events = {
      "click .link[data-link]": "navigate"
    };

    App.prototype.views = {};

    App.prototype.previous = null;

    App.prototype.current = null;

    App.prototype.stack_el = "#stack";

    App.prototype.initialize = function() {
      return _.bindAll(this, 'render', 'push', 'navigate');
    };

    App.prototype.push = function(view) {
      this.previous = this.current;
      this.current = view;
      if (this.previous) {
        this.previous.$el.addClass("left").removeClass("center");
      }
      if (this.views.hasOwnProperty(this.current.name)) {
        this.views[this.current.name].$el.addClass("center").removeClass("right");
        this.views[this.current.name].$el.one('transitionend', (function(_this) {
          return function(e) {
            return _this.previous.$el.addClass("right").removeClass("left");
          };
        })(this));
      } else {
        this.current.render();
        this.views[view.name] = view;
        this.current.$el.addClass("right");
        $(this.stack_el).append(this.current.$el);
        _.delay((function(_this) {
          return function() {
            _this.current.$el.addClass("center").removeClass("right");
            return _this.current.$el.one('transitionend', function(e) {
              return _this.previous.$el.addClass("right").removeClass("left");
            });
          };
        })(this), 20);
      }
      return Backbone.trigger(this.current.name + ":page-pushed");
    };

    App.prototype.navigate = function(e) {
      var next;
      e.preventDefault();
      next = $(e.currentTarget).data("link");
      return Tracker.Instance.main_router.navigate(next, {
        trigger: true
      });
    };

    App.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    return App;

  })(Backbone.View);

}).call(this);
