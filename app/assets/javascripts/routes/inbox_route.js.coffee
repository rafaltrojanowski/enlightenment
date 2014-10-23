EnlightenmentApp.InboxRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    # trigger a find
    @store.find "content_entity",
      inbox: true
      user_id: @get('session.user_id')

    # return a live filter (updates when the store updates)
    # @store.filter "content_entity", (record) ->
      # record.get("inbox") is true
