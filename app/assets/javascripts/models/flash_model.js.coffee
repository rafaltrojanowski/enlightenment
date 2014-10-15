EnlightenmentApp.FlashModel = Ember.Object.extend(
  type: null
  message: null
  isAlert: Ember.computed.equal("type", "alert")
  isSuccess: Ember.computed.equal("type", "success")
  clear: ->
    @update null, null
    return

  update: (type, message) ->
    @set "type", type
    @set "message", message
    return

  success: (message) ->
    @update "success", message
    return

  alert: (message) ->
    @update "alert", message
    return
)

