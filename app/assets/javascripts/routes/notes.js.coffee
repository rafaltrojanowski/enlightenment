EnlightenmentApp.NotesRoute = Ember.Route.extend
  model: ->
    @get('store').findAll 'note'
