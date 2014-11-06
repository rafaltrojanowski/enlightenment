EnlightenmentApp.UploadFile = Ember.TextField.extend
  tagName: 'input'
  attributeBindings: ['name']
  type: 'file'
  file: null
  vare: 'tescik'
  didInsertElement: ->
    controller = @get('parentView.controller')
    controller.send('setAvatar', 'bravoooo')
  change: (e) =>
    self = this
    reader = new FileReader()
    reader.onload = (e) =>
      console.log('beginng')
      fileToUpload = e.target.result
      Ember.run ->
        @set('file', fileToUpload)
    reader.readAsDataURL(e.target.files[0])
