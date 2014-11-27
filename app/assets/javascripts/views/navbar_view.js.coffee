EnlightenmentApp.NavbarView = Ember.View.extend
  didInsertElement: ->
    $('.search input[type=text]').keypress (event) ->
      if event.which is 13
        $('.trigger').click()