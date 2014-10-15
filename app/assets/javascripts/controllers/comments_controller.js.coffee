# EnlightenmentApp.CommentsController = Ember.ArrayController.extend
#   actions:
#     addEntry: ->
#       record = this.store.createRecord('content_entity',{
#         body: @get('newEntryName')
#       });

#       record.save().then ((result) ->
#         @transitionToRoute "content_entity.edit", result
#       ).bind(this)

#       @set('newEntryName', "")

# EnlightenmentApp.CommentsNewController = Ember.ObjectController.extend
#   needs: "content_entity"
#   content: null
#   actions:
#     addComment: ->
#       contententity = @get("controllers.content_entity.content")
#       comment = @get("store").createRecord("comment",
#         content_entity: contententity
#         content: @get("commentBody")
#       );
#       comment.save().then (comment) ->
#         contententity.get("comments").pushObject comment

#       # comment.save().then ((result) ->
#       #   # @transitionToRoute "content_entity.edit", result
#       # ).bind(this)

#       # @get("target").transitionTo "contententity"
#       # return
#       @set('commentBody', "")
