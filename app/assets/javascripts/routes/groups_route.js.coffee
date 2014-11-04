EnlightenmentApp.GroupsRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @get('store').find('group')
