EnlightenmentApp.GroupsNewController = Ember.Controller.extend
  logo: ""
  actions:
    addGroup: ->
      if @get('newGroup').trim()
        record = this.store.createRecord('group',{
          name: @get('newGroup')
          icon: @get('logo')
          owner_id: @get('session.user_id')
        })
        record.save()
        @set('newGroup')
        @transitionToRoute('groups')
        alertify.success("New group added!")
    setIconName: (name) ->
      @set('logo', name)


