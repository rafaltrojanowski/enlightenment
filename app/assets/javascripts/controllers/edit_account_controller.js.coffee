EnlightenmentApp.EditAccountController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,
  hello: "witam"

  actions:
    update: (route) ->
      @get('model').save().then ((response)->
        alertify.success("account update succesful")
      ), (response) ->
        error = response.responseJSON.error
        alertify.error(error)

    cancel: ->
      @content.rollback()
      console.log('cancel')
      @transitionToRoute('content_entities')