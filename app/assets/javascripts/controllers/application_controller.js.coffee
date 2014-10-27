EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  groups: (->
    @get("store").find "group"
  ).property()

  actions:
    changeGroup: (content_entity_id, group_id) ->
      console.log content_entity_id
      console.log group_id
      model = @store.find("content_entity", content_entity_id)

      @store.find("group", group_id).then (group) ->
        model.set("group", group)
        model.set("group_id", group_id).then (model) ->
          model.save().then ->
            alertify.success("Group changed!")

)
