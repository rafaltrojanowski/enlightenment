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
  @resource 'link', path: 'links/:link_id', ->
    @resource 'comments'
  @resource 'notes'
  @resource 'note', path: 'notes/:note_id'
  @resource 'groups', ->
    @route 'new'
  @resource 'group', path: 'groups/:group_id'

EnlightenmentApp.ModalView = Ember.View.extend(
  didInsertElement: ->
    Ember.run.next this, ->
      @$(".modal, .modal-backdrop").addClass "in"
      return

    return

  layoutName: "modal_layout"
  actions:
    close: ->
      view = this
      # use one of: transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd
      # events so the handler is only fired once in your browser
      @$(".modal, .modal-backdrop").one "transitionend", (ev) ->
        view.controller.send "close"
        return

      @$(".modal").removeClass "in"
      return
)

EnlightenmentApp.IndexRoute = Ember.Route.extend(
  beforeModel: ->
    @transitionTo "content_entities" # TODO home
)

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

EnlightenmentApp.LinksRoute = Ember.Route.extend
  model: ->
    @get('store').find('link')

EnlightenmentApp.CommentsRoute = Ember.Route.extend(
  model: ->
    @modelFor('link').get 'comments' # link.index?
)

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

