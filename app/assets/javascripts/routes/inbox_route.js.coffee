EnlightenmentApp.InboxRoute = Ember.Route.extend
  model: ->
    # trigger a find
    @store.find "content_entity",
      inbox: true

    # return a live filter (updates when the store updates)
    # @store.filter "content_entity", (record) ->
      # record.get("inbox") is true
