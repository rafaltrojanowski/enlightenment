# For more information see: http://emberjs.com/guides/routing/

EnlightenmentApp.Router.map ()->
  @route "home"
  @route "help"
  @route "login"
  @route "registration"
  @resource 'content_entities'
  @resource 'content_entity', path: 'content_entities/:content_entity_id', ->
    @route "edit"
  @resource 'links'
  @resource 'link', path: 'links/:link_id'
  @resource 'notes'
  @resource 'note', path: 'notes/:note_id'

EnlightenmentApp.IndexRoute = Ember.Route.extend(
  beforeModel: ->
    @transitionTo "content_entities" # TODO home
)

EnlightenmentApp.ContentEntitiesRoute = Ember.Route.extend
  beforeModel: (transition) ->
    unless @controllerFor("auth").get("isAuthenticated")
      loginController = @controllerFor("auth")
      loginController.set "previousTransition", transition
      @transitionTo "login"

  model: ->
    @get('store').find('content_entity')

EnlightenmentApp.ContentEntityEditRoute = Ember.Route.extend
  test: true # TODO

EnlightenmentApp.LinksRoute = Ember.Route.extend
  model: ->
    @get('store').find('link')

EnlightenmentApp.NotesRoute = Ember.Route.extend
  model: ->
    @get('store').find('note')

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


