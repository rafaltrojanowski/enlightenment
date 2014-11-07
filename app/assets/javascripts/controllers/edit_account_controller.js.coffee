EnlightenmentApp.EditAccountController = Ember.ObjectController.extend SimpleAuth.ApplicationRouteMixin,
  blank: 'http://img2.wikia.nocookie.net/__cb20130607025329/creepypasta/images/3/38/Avatar-blank.jpg'
  previewAvatar: Em.computed.alias('avatar')
  actions:
    update: (route) ->
      self = this
      model = @get('model')
      image_data = $('#avatar').attr('src')
      model.set('avatar', image_data)

      model.save().then ((response)->
        self.transitionToRoute('content_entities');
        alertify.success("Account updated succesfully")
      ), (response) ->
        error = response.responseJSON.error
        alertify.error(error)

    cancel: ->
      @transitionToRoute('content_entities')

