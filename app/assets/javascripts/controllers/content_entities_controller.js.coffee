EnlightenmentApp.ContentEntitiesController = Ember.ArrayController.extend
  sortProperties: ['updated_at'],
  sortAscending: false,
  sortContent: (->
    content = @get("content").sortBy("-_content")
    return unless content
    console.log "--sorting by ID desc--"
    content.forEach (item) ->
      console.log item.get("_content")
      console.log item.get("type")
      console.log item.get("updated_at")
      console.log item
      return

    return
  ).observes("content.@each")
  # entries: []

  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        _content: @get('newEntryName')
      });
      record.save();
      # @entries.pushObject name: @get('newEntryName')
      @set('newEntryName', "")
