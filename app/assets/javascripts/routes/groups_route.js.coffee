EnlightenmentApp.GroupsRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @get('store').findAll('group')

EnlightenmentApp.GroupRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin
