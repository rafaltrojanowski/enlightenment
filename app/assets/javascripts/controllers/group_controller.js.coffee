EnlightenmentApp.GroupController = Ember.ObjectController.extend
  title: 'Groups'
  isEditing: false
  bufferedName: Ember.computed.oneWay('name')
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')
  iconLarge: (->
    @get('icon') + ' fa-lg'
  ).property('icon')

  actions:
    update: ->
      userIds = $("#members").tokenInput("get").mapBy("id")
      model = @get('model')
      users = @get('users')

      store = @store

      @get('users').map (u) ->
        store.find("user", u.id).then (user) ->
          users.removeObject(user)

      for id in userIds
        @store.find("user", id).then (user) ->
          users.pushObject(user)

       json = model.asJSON()
       json.group.userIds = userIds

       $.ajax("api/v1/groups/" + @get('id'), method: 'PUT', data: json)

    save: ->
      @get('model').save()
      alertify.success("Group updated!")

    destroy: ->
      self = this
      group = @get('model')

      alertify.confirm "Delete group?", (e) ->
        if e
          group.deleteRecord()
          group.save().then ((result) ->
            self.transitionToRoute('groups')
            alertify.success('Group was successfully deleted.')
          ).bind(this), ->
            group.rollback()
            alertify.error("You are not authorized!")
        return

    setIcon: (name) ->
      @set('icon', name)
      @get('model').save()

    editGroup: ->
      @set('isEditing', true)

    doneEditing: ->
      bufferedName = @get('bufferedName').trim()

      unless Ember.isEmpty(bufferedName)
        group = @get('model')
        group.set('name', bufferedName)
        group.save()

      @set('isEditing', false)

    cancelEditing: ->
      @set('isEditing', false)

    editGroup: ->
      @set('isEditing', true)
