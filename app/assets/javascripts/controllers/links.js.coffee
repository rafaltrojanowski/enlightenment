EnlightenmentApp.LinksController = Ember.ArrayController.extend
  actions:
    addEntry: ->
      record = this.store.createRecord('content_entity',{
        body: @get('newEntryName')
      });

      record.save().then ((result) ->
        @transitionToRoute "content_entity.edit", result
      ).bind(this)

      @set('newEntryName', "")