EnlightenmentApp.UploadFile = Ember.TextField.extend
  tagName: 'input'
  attributeBindings: ['name']
  type: 'file'
  file: null
  change: (e) ->
    if e.target.files[0].size < 102400
      self = this
      reader = new FileReader()
      reader.onload = (e) ->
        fileToUpload = e.target.result
        console.log(fileToUpload)
        Ember.run ->
          self.set('file', fileToUpload)
        $("#avatar").attr('src', fileToUpload)
      reader.readAsDataURL(e.target.files[0])
    else
      alertify.error('File is too big')
