EnlightenmentApp.animateModalClose = ->
  promise = new Ember.RSVP.Promise((resolve) ->
    Ember.run.later (->
      resolve msg: "Hold Your Horses"
      return
    ), 250
    return
  )
  # $(".modal.in").removeClass "in"
  # $(".modal-backdrop.in").removeClass "in"
  promise

EnlightenmentApp.animateModalOpen = ->
  promise = new Ember.RSVP.Promise((resolve) ->
    Ember.run.later (->
      resolve msg: "Hold Your Horses"
      return
    ), 250
    return
  )
  $(".modal").addClass "in"
  $(".modal-backdrop").addClass "in"
  promise
