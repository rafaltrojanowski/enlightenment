EnlightenmentApp.ContentEntitiesRoute = Ember.Route.extend
  # beforeModel: (transition) ->
    # unless @controllerFor("auth").get("isAuthenticated")
      # loginController = @controllerFor("auth")
      # loginController.set "previousTransition", transition
      # @transitionTo "login"

  model: ->
    @get('store').find('content_entity')

  actions:
    edit: (content_entity) ->
      @controllerFor("content_entities.modal").edit content_entity
      @send 'openModal', 'content_entities.modal'
      return
    confirmDelete: (content_entity) ->
      @controllerFor('confirm.delete').send('confirmDelete', content_entity, 'content_entity.index');
      @send 'openModal', 'confirm.delete'

EnlightenmentApp.ContentEntityEditRoute = Ember.Route.extend
  test: true # TODO

