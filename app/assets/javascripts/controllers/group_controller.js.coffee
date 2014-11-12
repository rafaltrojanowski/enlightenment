EnlightenmentApp.GroupController = Ember.ObjectController.extend
  title: 'Groups'
  iconLarge: (->
    @get('icon') + ' fa-lg'
  ).property('icon')
  isEditing: false
  bufferedName: Ember.computed.oneWay('name')

  actions:
    update: ->
      model = @get('model')
      users = model.get('users')

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
