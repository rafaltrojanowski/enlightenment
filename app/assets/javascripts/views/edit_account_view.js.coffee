EnlightenmentApp.EditAccountView = Ember.View.extend
  didInsertElement: ->
    $("#avatar").click ->
      $("#file_browse").click()
