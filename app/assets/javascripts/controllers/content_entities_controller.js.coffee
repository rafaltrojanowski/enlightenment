EnlightenmentApp.PaginatableMixin = Em.Mixin.create
  queryParams: ['type']
  type: null

  paginatedContent: (->
    page    = @get('page')
    perPage = @get('perPage')
    start   = (page - 1 ) * perPage
    end     = page * perPage

    type = @get("type")
    content_entities = @get("model")

    if type
      length = @get('arrangedContent').filterBy("type", type).length
      @set('contentLength', length)
      @get('arrangedContent').filterBy("type", type).slice(start, end)
    else
      length = @get('arrangedContent').length
      @set('contentLength', length)
      @get('arrangedContent').slice(start, end)
  ).property('arrangedContent.[]', 'page', 'perPage', 'type')

  pages: (->
    result = parseInt(@get('contentLength') / @get('perPage'))
    ++result if @get('contentLength') % @get('perPage') > 0
    result
  ).property('content.[]', 'perPage', 'contentLength')

EnlightenmentApp.ContentEntitiesController = Ember.ArrayController.extend EnlightenmentApp.PaginatableMixin,
  page:           1
  perPage:        10
  sortAscending:  false
  sortProperties: ['updated_at']
  title: 'Dashboard'

  actions:
    addEntry: ->
      if EnlightenmentApp.isInRoute('wall')
        group_id = @controllerFor('wall').get('currentGroupId')

      record = @store.createRecord('content_entity',{
        body: @get('newEntryName')
        user_id: @get('session.user_id')
        group_id: group_id
      });

      record.save().then ((result) ->
        # @controllerFor("content_entities.modal").edit result
        # @send 'openModal', 'content_entities.modal'
        alertify.success("New record added!")
      ).bind(this), ->
        alertify.error("Your record is invalid!")
      @set('newEntryName', "")
    test: ->
      meta = @store.metadataFor('content_entity')
      console.log(meta.total)

