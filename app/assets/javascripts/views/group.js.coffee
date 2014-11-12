EnlightenmentApp.GroupView = Ember.View.extend
  didInsertElement: ->
    controller = @get('controller')
    select2_options =
      multiple: true
      width: 300
      ajax:
        url: "/api/v1/groups/14/other_users.json",
        dataType: "json"
        type: "GET"
        quietMillis: 50
        data: (term) ->
          term: term

        results: (data) ->
          results: $.map(data, (item) ->
            text: item.text
            id: item.id
          )

    @$("input").select2(select2_options).on "change", ((obj) ->
        return
      ).bind(this)

    $('.icon').click ->
      logo = $(this).data('name')
      logo = "fa fa-" + logo
      controller.send('setIcon', logo)
      $('.icon').css("border", "none")
      $(this).css('border', "solid 2px green")
      $(this).css("border-radius", "7px")
