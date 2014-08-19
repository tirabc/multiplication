// Generated by CoffeeScript 1.7.1
(function() {
  var App;

  App = (function() {
    function App() {}

    App.prototype.init = function() {
      this.main_router = new Tracker.Routers.Main;
      return Backbone.history.start();
    };

    App.prototype.user = {
      playing: false,
      score: 0
    };

    return App;

  })();

  $('document').ready(function() {
    Tracker.Instance = new App;
    return Tracker.Instance.init();
  });

}).call(this);
