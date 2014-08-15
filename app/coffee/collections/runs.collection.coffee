class Tracker.Collections.Runs extends Backbone.Collection
  
  model: Tracker.Models.Run
  localStorage: new Backbone.LocalStorage("tracker")
  
  formatAeraData: () ->
    data = []
    for model in @models
      do (model) ->
        data.push(
          date: model.get('date')
          time: model.get('time')
          distance: model.get('distance')
        )
    data