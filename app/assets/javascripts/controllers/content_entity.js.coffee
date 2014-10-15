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

  actions:
    edit: (content_entity) ->
      @controllerFor("content_entities.modal").edit content_entity
      @send 'openModal', 'content_entities.modal'
      return

    confirmDelete: (content_entity) ->
      @controllerFor('confirm.delete').send('confirmDelete', content_entity, 'content_entities');
      @send 'openModal', 'confirm.delete'
    # TODO remove gotoEdit
    gotoEdit: (model) ->
      this.transitionTo('content_entity.edit', model);

    addComment: (param) ->
      contententity = @get('content_entity.content')
      comment = @get("store").createRecord("comment",{
        commentable_type: "ContentEntity",
        commentable_id: param.id,
        content: @get("commentBody")
      });

      comment.save().then ((result) ->
        @get("comments").pushObject comment
      ).bind(this)
      @set('commentBody', "")

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
});
