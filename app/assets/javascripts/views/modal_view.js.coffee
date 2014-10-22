EnlightenmentApp.ModalView = Em.View.extend(
  # layout: Em.Handlebars.compile("{{yield}}<div class=modal-backdrop></div>"),

  didInsertElement: ->
    EnlightenmentApp.animateModalOpen()
    $("body").on "keyup.modal", ((event) ->
      @get("controller").send "close"  if event.keyCode is 27
      return
    ).bind(this)
    @$("input[type=text]").first().focus()
    return

  willDestroyElement: ->
    $("body").off "keyup.modal"
    return
)
EnlightenmentApp.ContentEntitiesModalView = EnlightenmentApp.ModalView.extend()
EnlightenmentApp.ConfirmDeleteView = EnlightenmentApp.ModalView.extend()
