EnlightenmentApp.NotesController = Ember.ArrayController.extend
  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        body: @get('newEntryName')
      });

      record.save()

      @set('newEntryName', "")