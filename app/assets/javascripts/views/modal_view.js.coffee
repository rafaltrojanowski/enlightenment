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
    
    tags = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
      queryTokenizer: Bloodhound.tokenizers.whitespace
      limit: 10
      prefetch:
        url: "api/v1/tags.json"
        filter: (list) ->
          $.map list, (tag) ->
            name: tag
    )

    tags.initialize()

    $(".tm-input").tagsManager({
        prefilled: tag_array,
        hiddenTagListName: 'hidden_tags',
        hiddenTagListId: 'hid_tag',
        isClearInputOnEsc: true
    })

    $(".tm-input").typeahead(null,
      name: "tags"
      displayKey: "name"
      source: tags.ttAdapter()
    ).on('typeahead:selected', (obj, datum) ->
      $(".tm-input").val('')
    )

  willDestroyElement: ->
    $("body").off "keyup.modal"
    return
)
EnlightenmentApp.ContentEntitiesModalView = EnlightenmentApp.ModalView.extend()
EnlightenmentApp.ConfirmDeleteView = EnlightenmentApp.ModalView.extend()
