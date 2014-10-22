EnlightenmentApp.LinksRoute = Ember.Route.extend
  # TODO current user notes

  model: ->
    # trigger a find
    @store.find "content_entity",
      type: 'link'

    # return a live filter (updates when the store updates)
    @store.filter "content_entity", (record) ->
      record.get("type") is 'link'
