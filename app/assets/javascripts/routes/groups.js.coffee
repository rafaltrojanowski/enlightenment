EnlightenmentApp.GroupsRoute = Ember.Route.extend
  model: ->
    @get('store').findAll('group')
