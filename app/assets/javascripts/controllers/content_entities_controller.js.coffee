EnlightenmentApp.ContentEntitiesController = Ember.ArrayController.extend
  entries: []

  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        _content: @get('newEntryName')
      });
      record.save();
      @entries.pushObject name: @get('newEntryName')
      @set('newEntryName', "")
