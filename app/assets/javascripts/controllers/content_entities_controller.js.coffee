EnlightenmentApp.PaginatableMixin = Em.Mixin.create
  queryParams: ['type']
  type: null

  filteredContentEntities: (->
    console.log @get('type')
    console.log 'test'

    type = @get("type")
    content_entities = @get("model")

    if type
      content_entities.filterBy "type", type
    else
      content_entities
  ).property("type", "model")

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

EnlightenmentApp.PaginationPageComponent = Em.Component.extend
  isCurrent: (-> @get('currentPage') == @get('page')).property('currentPage', 'page')
  tagName: 'li'
  classNameBindings: 'isCurrent:disabled'
  actions:
    pageClicked: ->
      @get('parentView').send('goToPage', @get('page'))

EnlightenmentApp.PaginationLinksComponent = Em.Component.extend
  hasPrevious:    (-> @get('page') > 1).property('page')
  hasNext:        (-> @get('page') + 1 < @get('pages')).property('page', 'pages')
  showPagination: Em.computed.gt('pages', 1)
  lastPage:       Em.computed.alias('pages')
  visiblePages: (->
      pages = @get('pages')
      page  = @get('page')

      # limit the number of pages to five, or the number of pages
      # if that is smaller.
      limit = 5
      limit = pages if pages < 5

      # function to calculate the last page given a start position
      # and a limit
      finish   = (start,limit)-> start + limit - 1

      # start at page - half the limit
      start = page - parseInt(limit / 2)
      # if that puts the last page shown as greater than the number
      # of pages, then move it back to the first start point that
      # doesn't cause an overrun.
      start = pages - limit + 1 if finish(start,limit) > pages
      # force start to the first page if the start is less than 1.
      start = 1 if start < 1

      [start..finish(start,limit)]
    ).property('page', 'pages')
  showBeforeElipsis: (-> @get('visiblePages.firstObject') > 3).property('visiblePages.[]')
  showAfterElipsis:  (-> Math.abs(@get('lastPage') - @get('visiblePages.lastObject')) > 2).property('visiblePages.[]', 'lastPage')
  actions:
    goToNextPage: ->
      @incrementProperty('controller.page') if @get('hasNext')

    goToPreviousPage: ->
      @decrementProperty('controller.page') if @get('hasPrevious')

    goToPage: (pageNumber)->
      @set('controller.page', pageNumber) if pageNumber >= 1 && pageNumber <= @get('lastPage')

EnlightenmentApp.ContentEntitiesController = Ember.ArrayController.extend EnlightenmentApp.PaginatableMixin,
  page:           1
  perPage:        5
  sortAscending: false,
  sortProperties: ['updated_at']

  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        body: @get('newEntryName')
      });

      record.save().then ((result) ->
        # @controllerFor("content_entities.modal").edit result
        # @send 'openModal', 'content_entities.modal'
        alertify.success("New record added!")
      ).bind(this), ->
        alertify.error("Your record is invalid!")

      @set('newEntryName', "")
      # EnlightenmentApp.get("flash").success "New record added!"
