EnlightenmentApp.WallRoute = Ember.Route.extend
  model: (params) ->
    @get('store').find('group', params.group_id)