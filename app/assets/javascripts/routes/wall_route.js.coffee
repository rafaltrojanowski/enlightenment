EnlightenmentApp.WallRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: (params) ->
    @get('store').find('group', params.group_id)
