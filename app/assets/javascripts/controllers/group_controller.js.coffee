EnlightenmentApp.GroupController = Ember.ObjectController.extend
  urlPath: (->
    "http://" + location.host + "/api/v1/groups/" + @get('id') + "/other_users.json"
  ).property('id')
  iconLarge: (->
    @get('icon') + ' fa-lg'
  ).property('icon')
  isEditing: false
  bufferedName: Ember.computed.oneWay('name')

  actions:
    update: ->
      tokens = $("#members").tokenInput("get").mapBy("id")
      user_ids = @get('user_ids').split(',').map( Number )

      for old_member in user_ids
        unless tokens.contains old_member
          usr = @store.getById('user', old_member)
          @get('users').removeObject(usr)
          console.log(usr)

      for new_member in tokens
        unless user_ids.contains new_member
          @store.find('user', new_member)
          usr = @store.getById('user', new_member)
          @get('users').pushObject(usr)

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
