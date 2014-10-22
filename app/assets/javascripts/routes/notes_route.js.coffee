EnlightenmentApp.NotesRoute = Ember.Route.extend
  model: ->
    @get('store').find('note')

