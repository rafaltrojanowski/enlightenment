EnlightenmentApp.LinksController = Ember.ArrayController.extend EnlightenmentApp.PaginatableMixin,
  page:           1
  perPage:        10
  sortAscending: false,
  sortProperties: ['updated_at']

  queryParams: ['type']
  type: null

  title: 'My Links'

  paginatedContent: (->
    page    = @get('page')
    perPage = @get('perPage')
    start   = (page - 1 ) * perPage
    end     = page * perPage

    type = @get("type")
    links = @get("model")

    if type == 'inbox'
      length = @get('arrangedContent').filterBy("inbox", true).length
      @set('contentLength', length)
      @get('arrangedContent').filterBy("inbox", true).slice(start, end)
    else
      length = @get('arrangedContent').filterBy("inbox", false).length
      @set('contentLength', length)
      @get('arrangedContent').filterBy("inbox", false).slice(start, end)
  ).property('arrangedContent.[]', 'page', 'perPage', 'type')

  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        body: @get('newEntryName')
      });

      record.save().then ((result) ->
        @transitionToRoute "content_entity.edit", result
      ).bind(this)

      @set('newEntryName', "")
