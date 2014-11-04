EnlightenmentApp.EditAccountController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,

  actions:
    update: (route) ->
      self = this

      @get('model').save().then ((response)->
        self.transitionToRoute('content_entities');
        alertify.success("Account updated succesfully")
      ), (response) ->
        error = response.responseJSON.error
        alertify.error(error)

    cancel: ->
      @transitionToRoute('content_entities')
