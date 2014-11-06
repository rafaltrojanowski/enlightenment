EnlightenmentApp.EditAccountView = Ember.View.extend
  didInsertElement: ->
    $("#avatar").click ->
      $("#file_browse").click()
    console.log(@get('controller'))

Ember.UploadFile = Ember.TextField.extend
  tagName: 'input'
  attributeBindings: ['name', 'file']
  type: 'file'
  file: null
  change: (e) =>
    console.log('wejszlo')
    reader = new FileReader()
    reader.onload = (e) =>
      fileToUpload = e.target.result
      $("#avatar").attr('src', fileToUpload)
      $("#file_browse").attr('file', fileToUpload)
      console.log($("#avatarValue").val())
    reader.readAsDataURL(e.target.files[0])
