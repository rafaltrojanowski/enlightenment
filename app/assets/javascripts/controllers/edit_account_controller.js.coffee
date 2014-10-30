EnlightenmentApp.EditAccountController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,
  hello: "witam"

  actions:
    update: (route) ->
      @get('model').save()
    cancel: ->
      @content.rollback()
      console.log('cancel')
      @transitionToRoute('content_entities')