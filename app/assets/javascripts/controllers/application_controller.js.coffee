EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  title: ''

  currentUser: (->
    sessionId =  @get('session.user_id')
    currentUser = @store.find "user", sessionId
  ).property()

  groups: (->
    @get("store").find("group")
  ).property()

  content_entities: (->
    @get("store"). find "content_entity"
  ).property()

  atInbox: (->
    user_id = @get 'session.user_id'
    content_entities = @get("content_entities")
    content_entities.filterBy("inbox", true).filterBy("user_id", user_id).get "length"
  ).property('content_entities.@each.inbox')

  actions:
    changeGroup: (content_entity_id, group_id) ->
      model = @store.find("content_entity", content_entity_id)

      @store.find("group", group_id).then (group) ->
        model.set("group", group)
        model.set("group_id", group_id).then (model) ->
          model.save().then ->
            alertify.success("Group changed!")

)
