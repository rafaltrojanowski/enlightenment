EnlightenmentApp.NotesRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    # trigger a find
    @store.find "content_entity",
      type: 'note'

    # return a live filter (updates when the store updates)
    @store.filter "content_entity", (record) ->
      record.get("type") is 'note'
