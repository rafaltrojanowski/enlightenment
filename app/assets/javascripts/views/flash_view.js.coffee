EnlightenmentApp.FlashView = Ember.View.extend(
  templateName: "flash"
  classNames: ["alert"]
  classNameBindings: [
    "alert:alert-danger"
    "success:alert-success"
  ]
  messageBinding: "model.message"
  alertBinding: "model.isAlert"
  successBinding: "model.isSuccess"
  isEmpty: Ember.computed.empty("message")
  didInsertElement: ->
    @hide()  if @get("isEmpty")
    return

  onMessageChange: (->
    (if @get("isEmpty") then @hide() else @show())
    return
  ).observes("message")
  hide: ->
    @$().hide('slow')
    return

  show: ->
    @$().show('slow')
    return

  click: (e) ->
    e.preventDefault()
    @get("model").clear()
    return
)