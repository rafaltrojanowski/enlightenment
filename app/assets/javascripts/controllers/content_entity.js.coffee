EnlightenmentApp.ContentEntityController = Ember.ObjectController.extend
  isLink: (->
    if @get("type") == 'link'
      true
    else
      false
  ).property("type")
  fullAddress: (-> # TODO move to model
    @get("body")
  ).property("body")
  isNote: (->
    if @get("model.type") == 'note'
      true
    else
      false
  ).property("type")

EnlightenmentApp.ContentEntityEditController = Ember.ObjectController.extend({
  needs: [ 'content_entity' ]

  isEditing: true

  actions:
    # update: (model) ->
      # @storage.update model
      # @transitionTo "photos"

    # update: ->
    update: (model) ->
      newTitle = @get('title')
      record = @get('content');
      record.set("title", newTitle);
      record.save();

      # alert model
      # @storage.update model
      # @transitionTo "photos"

    cancel: ->
      alert 'cancel triggered'
});
