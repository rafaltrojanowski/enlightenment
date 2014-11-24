EnlightenmentApp.SearchRoute = Ember.Route.extend
  actions:
    search: (keyword) ->
      @transitionTo('search.results', keyword)