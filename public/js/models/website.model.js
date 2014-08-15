// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  CMS.Models.Website = (function(_super) {
    __extends(Website, _super);

    function Website() {
      return Website.__super__.constructor.apply(this, arguments);
    }

    Website.prototype.urlRoot = 'public/data/data.json';

    Website.prototype.parse = function(response, options) {
      response.sections = new CMS.Collections.Sections(response.sections);
      return response;
    };

    return Website;

  })(Backbone.Model);

}).call(this);
