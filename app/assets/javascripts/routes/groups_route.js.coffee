EnlightenmentApp.GroupsRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @get('store').findAll('group')
  # setTitleGroup: (->
  #   @controllerFor('application').set('title', 'Groups')
  # ).property()
EnlightenmentApp.GroupRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin
