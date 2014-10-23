EnlightenmentApp.InboxRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    currentUserId = @get('session.user_id')
    @store.filter 'content_entity', {inbox: true, user_id: currentUserId}, (content_entity) ->
      return content_entity.get('inbox') and content_entity.get("user_id") is currentUserId
