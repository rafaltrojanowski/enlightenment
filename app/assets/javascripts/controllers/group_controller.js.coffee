EnlightenmentApp.GroupController = Ember.ObjectController.extend
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')
  iconLarge: (->
    @get('icon') + ' fa-lg'
  ).property('icon')
  isEditing: false
  bufferedName: Ember.computed.oneWay('name')
  title: 'Groups'

  init: ->
    allUsers = @store.find('user')
    users = @get('users')

  actions:
    update: ->
      userIds = $("#members").tokenInput("get").mapBy("id")
      model = @get('model')
      users = @get('users')

      user_ids = @get('user_ids').split(',').map( Number )

      for id in user_ids
        @store.find("user", id).then (user) ->
          users.removeObject(user)

      for id in userIds
        @store.find("user", id).then (user) ->
          users.pushObject(user)
      model.save()

    save: ->
      @get('model').save()
      alertify.success("Group updated!")
    destroy: ->
      group = @get('model')
      alertify.confirm "Delete group?", (e) ->
        if e
          group.deleteRecord()
          group.save()
          @transitionToRoute('groups')
          alertify.success('group destroyed!')
        else
          alertify.error "You've clicked Cancel"
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
