EnlightenmentApp.UploadFile = Ember.TextField.extend
  tagName: 'input'
  attributeBindings: ['name']
  type: 'file'
  file: null
  change: (e) ->
    self = this
    reader = new FileReader()
    reader.onload = (e) ->
      fileToUpload = e.target.result
      Ember.run ->
        self.set('file', fileToUpload)
      $("#avatar").attr('src', fileToUpload)
    reader.readAsDataURL(e.target.files[0])
