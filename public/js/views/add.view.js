// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Tracker.Views.Add = (function(_super) {
    __extends(Add, _super);

    function Add() {
      return Add.__super__.constructor.apply(this, arguments);
    }

    Add.prototype.name = "add";

    Add.prototype.template = $("#tpl-add").html();

    Add.prototype.events = {};

    Add.prototype.className = "page";

    Add.prototype.initialize = function() {
      _.bindAll(this, 'render');
      return Tracker.Views.Page.prototype.initialize.call(this);
    };

    Add.prototype.render = function() {
      this.$el.html(this.template);
      return this;
    };

    return Add;

  })(Tracker.Views.Page);

}).call(this);
