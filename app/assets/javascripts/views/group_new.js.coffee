EnlightenmentApp.GroupsNewView = Em.View.extend

  didInsertElement: ->
    controller = @get('controller')
    $('.icon').click ->
      $('.icon').css("border", "none")
      $(this).css('border', "solid 2px green")
      $(this).css("border-radius", "7px")
      icon = $(this).data('name')
      icon = "fa fa-" + icon + " fa-lg"
      controller.send('setIconName', icon)
