EnlightenmentApp.NotesController = Ember.ArrayController.extend EnlightenmentApp.PaginatableMixin,
  page:           1
  perPage:        5
  sortAscending: false,
  sortProperties: ['updated_at']

  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        body: @get('newEntryName')
      });

      record.save()

      @set('newEntryName', "")
