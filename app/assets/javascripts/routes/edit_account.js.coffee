EnlightenmentApp.EditAccountRoute = Ember.Route.extend SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    current_user_ids = @get('session.user_id')
    @get('store').find('user', current_user_ids)