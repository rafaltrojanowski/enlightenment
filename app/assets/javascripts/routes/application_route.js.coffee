EnlightenmentApp.ApplicationRoute = Em.Route.extend SimpleAuth.ApplicationRouteMixin,
  actions:
    openModal: (modal) ->
      @render modal,
        into: "application"
        outlet: "modal"

      return

    closeModal: ->
      EnlightenmentApp.animateModalClose().then (->
        @render "empty",
          into: "application"
          outlet: "modal"

        return
      ).bind(this)
      return

EnlightenmentApp.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "content_entities"

