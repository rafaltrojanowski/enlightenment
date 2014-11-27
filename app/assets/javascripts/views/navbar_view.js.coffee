EnlightenmentApp.NavbarView = Ember.View.extend
  didInsertElement: ->
    controller = @get('controller')
    $('.search input[type=text]').keypress (event) ->
      if event.which is 13
        controller.send('search')