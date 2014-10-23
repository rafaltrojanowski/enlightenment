EnlightenmentApp.EditGroupView = Ember.TextField.extend
  didInsertElement: ->
    @$().focus()

Ember.Handlebars.helper('edit-group', EnlightenmentApp.EditGroupView)