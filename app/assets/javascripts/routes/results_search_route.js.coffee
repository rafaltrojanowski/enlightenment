EnlightenmentApp.SearchResultsRoute = Ember.Route.extend
  model: (params) ->
    @get('store').find('content_entity')