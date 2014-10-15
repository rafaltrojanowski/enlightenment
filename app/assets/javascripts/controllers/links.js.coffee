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

# EnlightenmentApp.LinksNewController = Ember.ObjectController.extend(
#   save: ->
#     @get('store').commit()

#   transitionAfterSave: ( ->
#     # when creating new records, it's necessary to wait for the record to be assigned
#     # an id before we can transition to its route (which depends on its id)
#     @transitionToRoute('link', @get('content')) if @get('content.id')
#   ).observes('content.id')
# )