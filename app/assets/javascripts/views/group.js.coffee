EnlightenmentApp.GroupView = Ember.View.extend
  attributeBindings: ['data-logo']

  didInsertElement: ->
    controller = @get('controller')
    getUrl = (id) ->
      "/api/v1/groups/" + id + "/members.json"
    group_id = $("#members").data("id")
    $.getJSON(getUrl(group_id), (members) ->
      $("#members").data("pre", members)
      $("#members").tokenInput( $("#members").data("url") ,
        propertyToSearch: "email",
        preventDuplicates: true
      ))
    $('.icon').click ->
      logo = $(this).data('name')      
      controller.send('setIcon', logo)
      $('.icon').css("border", "none")
      $(this).css('border', "solid 2px green")
      $(this).css("border-radius", "7px")




