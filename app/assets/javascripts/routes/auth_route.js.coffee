EnlightenmentApp.LoginRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  setupController: (controller, model) ->
    controller.set 'content', model
    controller.set "errorMsg", ""
  actions:
    login: ->
      log.info "Logging in..."
      @controllerFor("auth").login this
    cancel: ->
      log.info "cancelling login"
      @transitionTo 'home'

EnlightenmentApp.RegistrationRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  actions:
    register: ->
      log.info "Registering..."
      @controllerFor("auth").register this
    cancel: ->
      log.info "cancelling registration"
      @transitionTo 'home'

