EnlightenmentApp.ContentEntityController = Ember.ObjectController.extend
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
  fullAddress: (->
    @get("body")
  ).property("body")