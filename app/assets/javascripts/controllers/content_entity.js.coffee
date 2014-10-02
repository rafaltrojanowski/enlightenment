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
    update: ->
      newTitle = @get('title')
      record = @get('content');
      record.set("title", newTitle);
      record.save();
      this.transitionTo( 'content_entities' );

    cancel: ->
      alert 'cancel triggered'
});
