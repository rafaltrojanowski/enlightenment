EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  logo: ""
  actions:
    addGroup: ->
      if @get('newGroup').trim()
        user_id = @get('session.user_id')
        console.log(user_id)
        record = this.store.createRecord('group',{
          name: @get('newGroup')
          icon: @get('logo')
          owner_id: @get('session.user_id')
          user_ids: user_id
        })

        record.save()

        @store.find('user', user_id).then (user) ->
          record.get('users').then (users) ->
            users.pushObject(user)

        @set('newGroup')
        @transitionToRoute('groups')
        alertify.success("New group added!")
    setIconName: (name) ->
      @set('logo', name)
