EnlightenmentApp.ContentEntityController = Ember.ObjectController.extend
  sortAscending: false
  sortProperties: ['updated_at']
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

    addComment: (param) ->
      # contententity = @get('content_entity.content')
      comment = @get("store").createRecord("comment",{
        commentable_type: "ContentEntity",
        commentable_id: param.id,
        content: @get("commentBody")
        user_id: @get('session.user_id')
      });

      comment.save().then ((result) ->
        @get("comments").unshiftObject comment
        alertify.success("Comment added!")
      ).bind(this), ->
        alertify.error("Comment cant be blank!")
      @set('commentBody', "")
    deleteComment: (comment) ->
      alertify.confirm "Delete comment?", (e) ->
        if e
          comment.deleteRecord()
          comment.save()
          alertify.success "Comment destroyed!"
        else
          alertify.error "You've clicked Cancel"
        return
