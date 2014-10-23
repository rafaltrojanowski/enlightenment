EnlightenmentApp.CommentsRoute = Ember.Route.extend(SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @modelFor('link').get 'comments' # link.index?
    # @get('store').find('comment')
    # @get('store').find('content_entity')
)

EnlightenmentApp.CommentsNewRoute = Ember.Route.extend(SimpleAuth.AuthenticatedRouteMixin,
  setupController: (controller, model) ->
    controller.set "content", null
    return
)

