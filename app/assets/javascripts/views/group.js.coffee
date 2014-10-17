EnlightenmentApp.GroupView = Ember.View.extend

  didInsertElement: ->
    getUrl = (id) ->
      "/api/v1/groups/" + id + "/members.json"
    group_id = $("#members").data("id")
    $.getJSON(getUrl(group_id), (members) ->
      $("#members").data("pre", members)
      $("#members").tokenInput( $("#members").data("url") ,
        propertyToSearch: "email",
        preventDuplicates: true
      ))



