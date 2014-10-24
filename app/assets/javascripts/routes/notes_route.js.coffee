EnlightenmentApp.NotesRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    currentUserId = @get('session.user_id')
    @store.filter "content_entity", { type: 'note', user_id: currentUserId}, (content_entity) ->
      content_entity.get("user_id") is currentUserId and content_entity.get("type") is 'note'
