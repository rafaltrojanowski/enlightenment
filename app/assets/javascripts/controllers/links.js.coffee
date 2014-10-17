EnlightenmentApp.LinksController = Ember.ArrayController.extend EnlightenmentApp.PaginatableMixin,
  page:           1
  perPage:        1
  sortAscending: false,
  sortProperties: ['updated_at']

  queryParams: ['type']
  type: null

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

# EnlightenmentApp.LinksNewController = Ember.ObjectController.extend(
#   save: ->
#     @get('store').commit()

#   transitionAfterSave: ( ->
#     # when creating new records, it's necessary to wait for the record to be assigned
#     # an id before we can transition to its route (which depends on its id)
#     @transitionToRoute('link', @get('content')) if @get('content.id')
#   ).observes('content.id')
# )
