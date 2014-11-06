EnlightenmentApp.EditAccountController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,
  blank: 'http://img2.wikia.nocookie.net/__cb20130607025329/creepypasta/images/3/38/Avatar-blank.jpg'
  previewAvatar: Em.computed.alias('avatar')
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

    setAvatar: (avatar) ->
      console.log('in setAvatar')
      @set 'avatar', avatar
      console.log(@get('avatar'))

