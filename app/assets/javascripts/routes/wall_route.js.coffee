EnlightenmentApp.WallRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  beforeModel: (params) ->
    console.log 'test'

  model: (params) ->
    @get('store').find('group', params.group_id)
