EnlightenmentApp.ModalView = Em.View.extend(
  # layout: Em.Handlebars.compile("{{yield}}<div class=modal-backdrop></div>"),

  didInsertElement: ->
    controller = @get('controller')
    tag_list = controller.get('tag_list')
    tag_array = String(tag_list).split(',')

    EnlightenmentApp.animateModalOpen()
    $("body").on "keyup.modal", ((event) ->
      @get("controller").send "close"  if event.keyCode is 27
      return
    ).bind(this)
    @$("input[type=text]").first().focus()
    $(".tm-input").tagsManager({
        prefilled: tag_array,
        hiddenTagListName: 'hidden_tags',
        hiddenTagListId: 'hid_tag',
        isClearInputOnEsc: true
    })
    return

  willDestroyElement: ->
    $("body").off "keyup.modal"
    return
)
EnlightenmentApp.ContentEntitiesModalView = EnlightenmentApp.ModalView.extend()
EnlightenmentApp.ConfirmDeleteView = EnlightenmentApp.ModalView.extend()
