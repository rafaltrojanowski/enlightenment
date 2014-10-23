EnlightenmentApp.LinksRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  # TODO current user notes

  model: ->
    # trigger a find
    @store.find "content_entity",
      type: 'link'
      user_id: @get('session.user_id')

    # return a live filter (updates when the store updates)
    # @store.filter "content_entity", (record) ->
      # record.get("type") is 'link'
