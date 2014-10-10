EnlightenmentApp.GroupView = Ember.View.extend
  didInsertElement: ->
    $("#members").tokenInput( $("#members").data("url") ,
      propertyToSearch: "email",
      preventDuplicates: true
    )
