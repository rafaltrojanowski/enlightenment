EnlightenmentApp.ApplicationController = Ember.Controller.extend(
  title: ''

  currentUser: (->
    sessionId =  @get('session.user_id')
    currentUser = @store.find "user", sessionId
  ).property()

  groups: (->
    @get("store").find("group")
  ).property()

  inboxed: (->
    @store.filter 'content_entity', {inbox: true}, (content_entity) ->
      content_entity.get('inbox')
  ).property()

  atInbox: (->
    inboxed = @get("inboxed")
    inboxed.get "length"
  ).property('inboxed.@each.inbox')

  actions:
    changeGroup: (content_entity_id, group_id) ->
      model = @store.find("content_entity", content_entity_id)

      @store.find("group", group_id).then (group) ->
        model.set("group", group)
        model.set("inbox", false)
        model.set("group_id", group_id).then (model) ->
          model.save().then ->
            alertify.success("Group changed!")

)
